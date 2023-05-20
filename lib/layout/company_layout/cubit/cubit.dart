// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../config/config.dart';
import '../../../models/comment_model.dart';
import '../../../models/comment_notification.dart';
import '../../../models/company.dart';
import '../../../models/enroll_request_notification.dart';
import '../../../models/notification_model.dart';
import '../../../models/training_model.dart';
import '../../../modules/company_notification_screen/company_notification_screen.dart';
import '../../../modules/company_training_screen/company_trainings_screen.dart';
import '../../../modules/complete_setup_profile/complete_setup_profile.dart';
import '../../../modules/upload_training_screen/upload_training_screen.dart';
import '../../../shared/constants.dart';
import 'states.dart';

enum CategoryType {
  Design,
  Development,
  Business,
  Office_Productivity,
  Finance_And_Accounting,
  IT_And_Software,
  Marketing,
  Photography,
}

class CompanyCubit extends Cubit<LayoutStates> {
  CompanyCubit() : super(LayoutInitialState());

  static CompanyCubit get(BuildContext context, [bool listener = true]) =>
      BlocProvider.of(context, listen: listener);

  @override
  Future<void> close() async {
    dispose();
    super.close();
  }

  // Layout Page

  int currentIndex = 0;

  Company? company;
  List<TrainingPostModel> trainings = [];
  List<CommentNotification> commentNotifications = [];
  List<EnrollRequestNotification> enrollRequestNotifications = [];

  List<MyNotification> get notification {
    List<MyNotification> list = [];
    for (var notification in commentNotifications) {
      list.add(notification);
    }
    for (var notification in enrollRequestNotifications) {
      list.add(notification);
    }
    list.sort(MyNotification.compareNotifications);
    return list.reversed.toList();
  }

  List<String> titles = const [
    'Home',
    'Upload Training',
    'Notifications',
    'Settings',
  ];

  List<Widget> screen = const [
    //ToDo: implement pull to refresh for all this screens
    CompanyTrainingsScreen(),
    UploadTrainingScreen(),
    CompanyNotificationScreen(),
    SetupProfile(openAsSettings: true),
  ];

  void changeDrawerScreen(int index) {
    currentIndex = index;
    if (index == 1) {
      clearForm();
    }
    emit(LayoutChangeScreenState());
  }

  void getCompanyInfo() {
    emit(GetCompanyInfoLoadingState());
    TrainingApp.firestore
        .collection(TrainingApp.company)
        .doc(uId)
        .get()
        .then((value) async {
      company = Company.fromJSON(value.data());
      TrainingApp.firebaseMessaging.subscribeToTopic(company!.uId);
      getMyTrainings();
      getCommentsNotifications();
      getEnrollRequestsNotifications();
      emit(GetCompanyInfoSuccessState());
    }).catchError((error) {
      emit(GetCompanyInfoErrorState(error.toString()));
    });
  }

  // Upload Training Page

  List<String> tags = [];
  List<String> learnedTitles = [];

  TextEditingController trainingTitleController = TextEditingController();
  TextEditingController trainingDescriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController hoursController = TextEditingController();
  TextEditingController hoursPerWeekController = TextEditingController();
  TextEditingController studentNoController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formInputs = {};

  void pickDate(DateTime? date) {
    dateController.text = DateFormat('MMMM d, yyyy').format(date!);
    emit(PickDateState());
  }

  void removePickedImage() {
    trainingImage = null;
    emit(RemovePickedImageState());
  }

  bool isSubmitAllowed = false;

  void allowSubmitting(String value) {
    if (value.isNotEmpty) {
      isSubmitAllowed = true;
    } else {
      isSubmitAllowed = false;
    }
    emit(AllowingSendSubmitState());
  }

  void addTag() {
    if (tagController.text.isNotEmpty) {
      tags.add(tagController.text);
      tagController.text = '';
      emit(AddTagState());
    }
  }

  void addTitle() {
    if (titleController.text.isNotEmpty) {
      learnedTitles.add(titleController.text);
      titleController.text = '';
      emit(AddLearnedTitleState());
    }
  }

  void dispose() {
    trainingTitleController.dispose();
    trainingDescriptionController.dispose();
    dateController.dispose();
    tagController.dispose();
    titleController.dispose();
    hoursController.dispose();
    hoursPerWeekController.dispose();
    studentNoController.dispose();
    commentController.dispose();
  }

  void clearForm() {
    trainingTitleController.text = '';
    trainingDescriptionController.text = '';
    tagController.text = '';
    titleController.text = '';
    dateController.text = '';
    hoursController.text = '';
    hoursPerWeekController.text = '';
    studentNoController.text = '';
    trainingImage = null;
    trainingImageURL = null;
    _formInputs.clear();
    tags.clear();
    learnedTitles.clear();
    categoryType = null;
  }

  String? validateTrainingTitle(trainingTitle) {
    if (trainingTitle!.isEmpty) {
      return 'Training Title mustn\'t be empty';
    } else if (trainingTitle.length < 7) {
      return 'Training Title must be at least 7 char long';
    }
    return null;
  }

  void saveTrainingTitle(trainingTitle) {
    _formInputs[TrainingApp.trainingTitle] = trainingTitle!;
  }

  String? validateTrainingDescription(trainingDescription) {
    if (trainingDescription!.isEmpty) {
      return 'Training Description mustn\'t be empty';
    } else if (trainingDescription.length < 30) {
      return 'Training Description must be at least 30 char long';
    }
    return null;
  }

  void saveTrainingDescription(trainingDescription) {
    _formInputs[TrainingApp.description] = trainingDescription!;
  }

  String? validateStartingDate(startingDate) {
    if (startingDate!.isEmpty) {
      return 'Starting Date mustn\'t be empty';
    } else {
      return null;
    }
  }

  void saveStartingDate(startingDate) {
    _formInputs[TrainingApp.startingDate] = startingDate!;
  }

  String? validateTotalHours(totalHours) {
    if (totalHours!.isEmpty) {
      return 'Please Enter An Approximated Hours Of this Training';
    } else {
      //ToDo : Check If Integer
      var value = int.tryParse(totalHours);
      if (value != null) {
        if (value < 0) {
          return 'Please Enter A Positive Integer Number';
        }
        return null;
      } else {
        return 'Please Enter An Integer Number';
      }
    }
  }

  void saveTotalHours(totalHours) {
    _formInputs[TrainingApp.totalHours] = int.tryParse(totalHours);
  }

  String? validateHoursPerWeek(hoursPerWeek) {
    if (hoursPerWeek!.isEmpty) {
      return 'Please Enter An Average Hours/Week for this Training';
    } else {
      //ToDo : Check If Integer
      var value = int.tryParse(hoursPerWeek);
      if (value != null) {
        if (value < 0) {
          return 'Please Enter A Positive Integer Number';
        }
        return null;
      } else {
        return 'Please Enter An Integer Number';
      }
    }
  }

  void saveHoursPerWeek(hoursPerWeek) {
    _formInputs[TrainingApp.hoursPerWeek] = int.tryParse(hoursPerWeek);
  }

  String? validateStudentNumbers(requiredStudentNo) {
    if (requiredStudentNo!.isEmpty) {
      return 'Please Enter A Required Student Numbers';
    } else {
      //ToDo : Check If Integer
      var value = int.tryParse(requiredStudentNo);
      if (value != null) {
        if (value < 0) {
          return 'Please Enter A Positive Integer Number';
        }
        return null;
      } else {
        return 'Please Enter An Integer Number';
      }
    }
  }

  void saveStudentNumbers(requiredStudentNo) {
    _formInputs[TrainingApp.requiredStudentNo] =
        int.tryParse(requiredStudentNo);
  }

  CategoryType? categoryType;

  void changeCategoryType(CategoryType? value) {
    categoryType = value;
    emit(ChangeCategoryTypeState());
  }

  Future<void> postTraining() async {
    if (formKey.currentState!.validate()) {
      if (tags.isEmpty ||
          learnedTitles.isEmpty ||
          trainingImage == null ||
          categoryType == null) {
        // ToDo : Show SnakeBars in the bottom
        if (trainingImage == null) {
          emit(NoSelectedImageErrorState(
              'No Image Selected, Please Add An Image.'));
        } else if (tags.isEmpty) {
          emit(TagsEmptyErrorState('No Tags Added, Please Add Some Tags.'));
        } else if (learnedTitles.isEmpty) {
          emit(LearnedTitlesEmptyErrorState(
              'No Learned Titles Added, Please Add Some Titles.'));
        } else {
          emit(NoCategoryTypeSelectedState(
              'Please Select a Category, It helps Student to reach out your Training.'));
        }
        return;
      } else {
        //ToDo : Submit Training And Save It In A Map.
        //ToDo : Add Training Category To the model.
        //ToDo : Add Enrolled Student To the model has integer value starts with 0.
        emit(UploadTrainingLoadingState());
        try {
          formKey.currentState!.save();
          trainingImageURL = await uploadTrainingImage();
          _formInputs[TrainingApp.trainingImage] = trainingImageURL!;
          _formInputs[TrainingApp.companyName] = company!.name;
          _formInputs[TrainingApp.companyId] = company!.uId;
          _formInputs[TrainingApp.isVerifiedCompany] = isAccountComplete;
          _formInputs[TrainingApp.companyProfileImage] = company!.avatarUrl;
          _formInputs[TrainingApp.trainingPostDate] = DateTime.now().toString();
          _formInputs[TrainingApp.tags] = tags;
          _formInputs[TrainingApp.learnedTitles] = learnedTitles;
          _getCategoryType();
          TrainingPostModel post = TrainingPostModel.fromJSON(
              _formInputs, Timestamp.now().toString());
          //DateTime.now().toIso8601String(),
          var value = await TrainingApp.firestore
              .collection(TrainingApp.trainings)
              .add(post.toMap());
          emit(UploadTrainingSuccessState());
          value.id;
          _notifyStudentAboutTraining(trainingId: value.id, training: post);
        } catch (error) {
          emit(UploadTrainingErrorState(error.toString()));
        }
      }
    }
  }

  void _getCategoryType() {
    switch (categoryType) {
      case CategoryType.Design:
        _formInputs[TrainingApp.category] = TrainingApp.design;
        break;
      case CategoryType.Development:
        _formInputs[TrainingApp.category] = TrainingApp.development;
        break;
      case CategoryType.Business:
        _formInputs[TrainingApp.category] = TrainingApp.business;
        break;
      case CategoryType.Office_Productivity:
        _formInputs[TrainingApp.category] = TrainingApp.officeProductivity;
        break;
      case CategoryType.Finance_And_Accounting:
        _formInputs[TrainingApp.category] = TrainingApp.financeAndAccounting;
        break;
      case CategoryType.IT_And_Software:
        _formInputs[TrainingApp.category] = TrainingApp.iTAndSoftware;
        break;
      case CategoryType.Marketing:
        _formInputs[TrainingApp.category] = TrainingApp.marketing;
        break;
      case CategoryType.Photography:
        _formInputs[TrainingApp.category] = TrainingApp.photography;
        break;
      default:
        break;
    }
  }

  File? trainingImage;

  Future<void> pickTrainingImage() async {
    emit(PickTrainingImageLoadingState());
    final pickedFile =
        await TrainingApp.picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      trainingImage = File(pickedFile.path);
      emit(PickTrainingImageSuccessState());
    } else {
      emit(PickTrainingImageErrorState('No Image Selected'));
    }
  }

  String? trainingImageURL;

  Future<String?> uploadTrainingImage() async {
    String msg = '';
    try {
      emit(UploadTrainingImageLoadingState());
      var value = await TrainingApp.firebaseStorage
          .ref()
          .child(
              'users/$uId/${Uri.file(trainingImage!.path).pathSegments.last}')
          .putFile(trainingImage!);
      msg = 'upload success';
      emit(UploadTrainingImageSuccessState());
      var url = await value.ref.getDownloadURL();
      // trainingImageURL = url;
      msg = 'getting image url success';
      emit(GetTrainingImageLinkSuccessState());
      return url;
    } catch (error) {
      if (msg == 'upload success') {
        emit(GetTrainingImageLinkErrorState(error.toString()));
      } else {
        emit(UploadTrainingImageErrorState(error.toString()));
      }
    }
    return null;
  }

  void getMyTrainings() {
    emit(GetMyTrainingsPostsLoadingState());
    try {
      TrainingApp.firestore
          .collection(TrainingApp.trainings)
          .orderBy(TrainingApp.trainingId)
          .where(TrainingApp.companyId, isEqualTo: company!.uId)
          .snapshots()
          .listen((event) {
        trainings = [];
        for (var element in event.docs) {
          trainings.add(TrainingPostModel.fromJSON(element.data(), element.id));
        }
        emit(GetMyTrainingsPostsSuccessState());
      });
    } catch (error) {
      emit(GetMyTrainingsPostsErrorState(error.toString()));
    }
  }

  TextEditingController commentController = TextEditingController();

  void writeComment({
    required String trainingId,
  }) {
    try {
      if (commentController.text.isNotEmpty) {
        TrainingApp.firestore
            .collection(TrainingApp.trainings)
            .doc(trainingId)
            .collection(TrainingApp.comments)
            .add(CommentModel(
              userName: company!.name,
              userProfileImage: company!.avatarUrl!,
              comment: commentController.text,
              commentDateTime: DateTime.now().toString(),
            ).toMap())
            .then((value) {
          commentController.text = '';
          isSubmitAllowed = false;
          emit(WritingTrainingCommentSuccessState());
        });
      }
    } catch (error) {
      emit(WritingTrainingCommentErrorState(error.toString()));
    }
  }

  void getCommentsNotifications() {
    TrainingApp.firestore
        .collection(TrainingApp.company)
        .doc(company!.uId)
        .collection(TrainingApp.commentsNotification)
        .orderBy(TrainingApp.dateTime)
        .snapshots()
        .listen((event) {
      commentNotifications = [];
      for (var element in event.docs) {
        commentNotifications.add(CommentNotification.fromJson(
          element.data(),
          element.id,
        ));
      }
      // notification;
      emit(GetMyTrainingsCommentNotificationState());
    });
  }

  void getEnrollRequestsNotifications() {
    TrainingApp.firestore
        .collection(TrainingApp.company)
        .doc(company!.uId)
        .collection(TrainingApp.enrollRequestsNotification)
        .orderBy(TrainingApp.dateTime)
        .snapshots()
        .listen((event) {
      enrollRequestNotifications = [];
      for (var element in event.docs) {
        enrollRequestNotifications.add(EnrollRequestNotification.fromJson(
          element.data(),
          element.id,
        ));
      }
      emit(GetMyTrainingsCommentNotificationState());
    });
  }

  void addStudentToTraining({
    required String notificationId,
    required String trainingId,
    required String studentId,
  }) {
    //ToDo: check if enrollment<=required student number Do Add.
    //ToDo: otherwise show Error Message(Show Toast or SnackBar).
    TrainingPostModel training =
        trainings.firstWhere((training) => training.id == trainingId);
    TrainingApp.firestore
        .collection(TrainingApp.trainings)
        .doc(trainingId)
        .collection(TrainingApp.enrollments)
        .get()
        .then((value) {
      if (value.docs.length < training.requiredStudentNo) {
        _removeEnrollRequestFromTraining(
          trainingId: trainingId,
          studentId: studentId,
        );
        _removeEnrollRequestNotification(notificationId: notificationId);
        _addEnrollmentToTraining(trainingId: trainingId, studentId: studentId);
        _addTrainingToStudentTrainings(
          trainingId: trainingId,
          studentId: studentId,
        );
        _notifyStudentAboutEnrollmentToTraining(
          trainingId: trainingId,
          studentId: studentId,
        );
        emit(AddStudentToATrainingSuccessState());
      } else {
        // In case if many students ask to enroll When there still a place for one student,
        // but another Student was selected instead.
        emit(AddStudentToATrainingErrorState('No Place for this Student'));
      }
    }).catchError((error) {
      emit(AddStudentToATrainingErrorState(error.toString()));
    });
  }

  void removeRequestStudentToTraining({
    required String notificationId,
    required String trainingId,
    required String studentId,
  }) {
    _removeEnrollRequestFromTraining(
      trainingId: trainingId,
      studentId: studentId,
    );
    _removeEnrollRequestNotification(notificationId: notificationId);
  }

  void _removeEnrollRequestNotification({
    required String notificationId,
  }) {
    TrainingApp.firestore
        .collection(TrainingApp.company)
        .doc(company!.uId)
        .collection(TrainingApp.enrollRequestsNotification)
        .doc(notificationId)
        .delete();
  }

  void _removeEnrollRequestFromTraining({
    required String trainingId,
    required String studentId,
  }) {
    TrainingApp.firestore
        .collection(TrainingApp.trainings)
        .doc(trainingId)
        .collection(TrainingApp.enrollRequests)
        .doc(studentId)
        .delete();
  }

  void _addEnrollmentToTraining({
    required String trainingId,
    required String studentId,
  }) {
    //ToDo: subtract 1 from Required Student number
    TrainingApp.firestore
        .collection(TrainingApp.trainings)
        .doc(trainingId)
        .collection(TrainingApp.enrollments)
        .doc(studentId)
        .set({
      TrainingApp.studentId: studentId,
    });
  }

  void _addTrainingToStudentTrainings({
    required String studentId,
    required String trainingId,
  }) {
    //ToDo: Add State Manage.
    TrainingApp.firestore
        .collection(TrainingApp.student)
        .doc(studentId)
        .collection(TrainingApp.studentTrainings)
        .doc(trainingId)
        .set({
          TrainingApp.trainingID: trainingId,
        })
        .then((value) {})
        .catchError((error) {});
  }

  void _notifyStudentAboutEnrollmentToTraining({
    required String trainingId,
    required String studentId,
  }) {
    TrainingPostModel training =
        trainings.firstWhere((element) => element.id == trainingId);
    TrainingApp.firestore
        .collection(TrainingApp.student)
        .doc(studentId)
        .collection(TrainingApp.enrollmentsNotifications)
        .add({
      TrainingApp.dateTime: DateTime.now().toString(),
      TrainingApp.trainingID: trainingId,
      TrainingApp.companyId: company!.uId, //
      TrainingApp.companyName: company!.name, //
      TrainingApp.companyProfileImage: company!.avatarUrl, //
      TrainingApp.trainingTitle: training.trainingTitle, //
      TrainingApp.trainingImage: training.trainingImage,
    });
  }

  void _notifyStudentAboutTraining({
    required TrainingPostModel training,
    required String trainingId,
  }) {
    TrainingApp.firestore.collection(TrainingApp.trainingNotifications).add({
      TrainingApp.dateTime: DateTime.now().toString(),
      TrainingApp.trainingID: trainingId,
      TrainingApp.companyName: company!.name, //
      TrainingApp.trainingTitle: training.trainingTitle, //
      TrainingApp.trainingImage: training.trainingImage,
    });
  }
}
