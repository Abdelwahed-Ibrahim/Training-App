import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../models/comment_model.dart';
import '../../../models/enrollment_notification.dart';
import '../../../models/notification_model.dart';
import '../../../models/student.dart';
import '../../../models/training_model.dart';
import '../../../models/uploaded_training_notification.dart';
import '../../../modules/complete_setup_profile/complete_setup_profile.dart';
import '../../../modules/home_screen/home_screen.dart';
import '../../../modules/my_training_screen/my_training_screen.dart';
import '../../../modules/notification_screen/notification_screen.dart';
import '../../../shared/constants.dart';
import 'states.dart';

//ToDo : determine the Training Status when getting the Trainings and effects the UI

class StudentCubit extends Cubit<AppStates> {
  StudentCubit() : super(AppInitialState());

  static StudentCubit get(context, [bool listener = true]) =>
      BlocProvider.of(context, listen: listener);

  int currentIndex = 0;

  Student? student;
  List<TrainingPostModel> trainings = [];
  List<TrainingPostModel> searchedTrainings = [];
  List<TrainingPostModel> myTrainings = [];
  Map<String, TrainingStatus> trainingStatus = {};
  List<EnrollmentNotification> enrollmentNotifications = [];
  List<UploadedTrainingNotification> uploadedTrainingNotifications = [];

  List<MyNotification> get notifications {
    List<MyNotification> list = [];
    for (var notification in enrollmentNotifications) {
      list.add(notification);
    }
    for (var notification in uploadedTrainingNotifications) {
      list.add(notification);
    }
    list.sort(MyNotification.compareNotifications);
    return list.reversed.toList();
  }

  Map<String, int> commentNo = {};

  void dispose() {
    commentController.dispose();
  }

  @override
  Future<void> close() async {
    dispose();
    super.close();
  }

  List<String> titles = const [
    'Features',
    'My Training',
    'Notifications',
    'Settings',
  ];

  TextEditingController commentController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<Widget> screens = const [
    HomeScreen(),
    MyTrainingScreen(),
    NotificationScreen(),
    SetupProfile(openAsSettings: true),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

  Future<void> getStudentInfo() async {
    emit(GetStudentInfoLoadingState());
    await TrainingApp.firestore
        .collection(TrainingApp.student)
        .doc(uId)
        .get()
        .then((value) async {
      student = Student.fromJSON(value.data());
      getEnrollmentsNotifications();
      await TrainingApp.firebaseMessaging.subscribeToTopic(uId!);
      await TrainingApp.firebaseMessaging
          .subscribeToTopic(TrainingApp.studentTopic);
      emit(GetStudentInfoSuccessState());
    }).catchError((error) {
      emit(GetStudentInfoErrorState(error.toString()));
    });
  }

  void getTrainings() {
    emit(GetTrainingsPostsLoadingState());
    try {
      TrainingApp.firestore
          .collection(TrainingApp.trainings)
          .orderBy(TrainingApp.trainingId, descending: true)
          .snapshots()
          .listen((event) {
        trainings = [];
        for (var element in event.docs) {
          trainings.add(TrainingPostModel.fromJSON(element.data(), element.id));
          element.reference
              .collection(TrainingApp.comments)
              .snapshots()
              .listen((value) {
            commentNo[element.id] = value.docs.length;
          });
        }
        _getTrainingsStatus();
        getUploadedTrainingsNotifications();
        getMyTrainings();
        emit(GetTrainingsPostsSuccessState());
      });
    } catch (error) {
      emit(GetTrainingsPostsErrorState(error.toString()));
    }
  }

  void searchTrainings(
    String searchedText, {
    bool isTag = false,
    bool isCategory = false,
  }) {
    searchedTrainings = [];
    if (searchedText.startsWith('#')) {
      isTag = true;
      searchedText = searchedText.substring(1);
    }
    for (var training in trainings) {
      if (isTag == false && isCategory == false) {
        if (training.trainingTitle
            .toLowerCase()
            .contains(searchedText.toLowerCase())) {
          searchedTrainings.add(training);
        } else if (training.category
            .toLowerCase()
            .contains(searchedText.toLowerCase())) {
          searchedTrainings.add(training);
        } else {
          for (var tag in training.tags) {
            if (tag.toLowerCase().contains(searchedText.toLowerCase())) {
              searchedTrainings.add(training);
            }
          }
        }
      } else if (isTag) {
        for (var tag in training.tags) {
          if (tag.toLowerCase().contains(searchedText.toLowerCase())) {
            searchedTrainings.add(training);
            break;
          }
        }
      } else if (isCategory) {
        //TODO: Search By Category
        if (training.category
            .toLowerCase()
            .contains(searchedText.toLowerCase())) {
          searchedTrainings.add(training);
        }
      }
    }
    // emit(SearchTrainingsPostsErrorState('No Posts Found'));
    emit(SearchTrainingsPostsSuccessState());
  }

  void getMyTrainings() {
    emit(GetMyTrainingsPostsLoadingState());
    try {
      TrainingApp.firestore
          .collection(TrainingApp.student)
          .doc(uId)
          .collection(TrainingApp.studentTrainings)
          .snapshots()
          .listen((event) {
        myTrainings = [];
        for (var trainingId in event.docs) {
          myTrainings.add(
              trainings.firstWhere((training) => training.id == trainingId.id));
        }
        emit(GetMyTrainingsPostsSuccessState());
      });
    } catch (error) {
      emit(GetMyTrainingsPostsErrorState(error.toString()));
    }
  }

  void _sendCommentNotificationToCompany({
    required String trainingId,
    required String trainingImage,
    required String companyId,
    required String dateTime,
  }) {
    try {
      TrainingApp.firestore
          .collection(TrainingApp.company)
          .doc(companyId)
          .collection(TrainingApp.commentsNotification)
          .add({
        TrainingApp.studentId: student!.uId,
        TrainingApp.studentName: student!.name,
        TrainingApp.studentAvatarUrl: student!.avatarUrl,
        TrainingApp.trainingID: trainingId,
        TrainingApp.trainingImage: trainingImage,
        TrainingApp.dateTime: dateTime,
      });
      emit(SendCompanyNotificationSuccessState());
    } catch (error) {
      emit(SendCompanyNotificationErrorState(error.toString()));
    }
  }

  void _sendEnrollRequestNotificationToCompany({
    required String trainingId,
    required String trainingImage,
    required String companyId,
    required String dateTime,
  }) {
    try {
      TrainingApp.firestore
          .collection(TrainingApp.company)
          .doc(companyId)
          .collection(TrainingApp.enrollRequestsNotification)
          .add({
        TrainingApp.studentId: student!.uId,
        TrainingApp.studentName: student!.name,
        TrainingApp.studentAvatarUrl: student!.avatarUrl,
        TrainingApp.trainingID: trainingId,
        TrainingApp.trainingImage: trainingImage,
        TrainingApp.dateTime: dateTime,
      });
      emit(SendCompanyNotificationSuccessState());
    } catch (error) {
      emit(SendCompanyNotificationErrorState(error.toString()));
    }
  }

  void _removeNotificationOfEnrollmentRequest({
    required String trainingId,
    required String companyId,
  }) {
    try {
      TrainingApp.firestore
          .collection(TrainingApp.company)
          .doc(companyId)
          .collection(TrainingApp.enrollRequestsNotification)
          .get()
          .then((value) {
        for (var notification in value.docs) {
          if (notification.data()[TrainingApp.studentId] == student!.uId &&
              notification.data()[TrainingApp.trainingID] == trainingId) {
            notification.reference.delete();
            emit(RemoveCompanyNotificationSuccessState());
          }
        }
      });
    } catch (error) {
      emit(RemoveCompanyNotificationErrorState(error.toString()));
    }
  }

  void writeComment({required String trainingId}) {
    //ToDo: Add States to keep track of the method
    String dateTime = DateTime.now().toString();
    try {
      if (commentController.text.isNotEmpty) {
        TrainingApp.firestore
            .collection(TrainingApp.trainings)
            .doc(trainingId)
            .collection(TrainingApp.comments)
            .add(CommentModel(
              userName: student!.name,
              userProfileImage: student!.avatarUrl!,
              comment: commentController.text,
              commentDateTime: dateTime,
            ).toMap())
            .then((value) {
          commentController.text = '';
          isSubmitAllowed = false;
          TrainingPostModel training =
              trainings.firstWhere((element) => element.id == trainingId);
          _sendCommentNotificationToCompany(
            trainingId: trainingId,
            trainingImage: training.trainingImage,
            companyId: training.companyId,
            dateTime: dateTime,
          );
          _getTrainingsCommentNumber();
        });
        emit(WritingTrainingCommentSuccessState());
      }
    } catch (error) {
      emit(WritingTrainingCommentErrorState(error.toString()));
    }
  }

  Future<void> requestToEnrollTraining({required String trainingId}) async {
    // ToDo: Add States to keep track of the method
    // ToDo: Check the number of the enrolled student Enrollment collection.length
    // ToDo: if its smaller than (i.e. not >=) the required student number do request
    TrainingPostModel myTraining =
        trainings.firstWhere((training) => training.id == trainingId);
    var isEnrolled = await TrainingApp.firestore
        .collection(TrainingApp.trainings)
        .doc(trainingId)
        .collection(TrainingApp.enrollments)
        .doc(uId)
        .get();
    TrainingApp.firestore
        .collection(TrainingApp.trainings)
        .doc(trainingId)
        .collection(TrainingApp.enrollments)
        .get()
        .then((value) {
      if (value.docs.length < myTraining.requiredStudentNo) {
        if (isEnrolled.data() == null) {
          String dateTime = DateTime.now().toString();
          TrainingApp.firestore
              .collection(TrainingApp.trainings)
              .doc(trainingId)
              .collection(TrainingApp.enrollRequests)
              .doc(uId)
              .get()
              .then((value) {
            if (value.data() == null) {
              value.reference.set({
                TrainingApp.studentId: uId,
              }).then((value) {
                TrainingPostModel training =
                    trainings.firstWhere((element) => element.id == trainingId);
                _sendEnrollRequestNotificationToCompany(
                  trainingId: trainingId,
                  trainingImage: training.trainingImage,
                  companyId: training.companyId,
                  dateTime: dateTime,
                );
                emit(RequestToEnrollTrainingSuccessState());
              }).catchError((error) {
                emit(RequestToEnrollTrainingErrorState(error.toString()));
              });
            } else if (value.data()![TrainingApp.studentId] == uId) {
              value.reference.delete();
              TrainingPostModel training =
                  trainings.firstWhere((element) => element.id == trainingId);
              _removeNotificationOfEnrollmentRequest(
                trainingId: trainingId,
                companyId: training.companyId,
              );
              emit(RemoveRequestToEnrollOnTrainingState());
            }
          }).catchError((error) {
            emit(RequestToEnrollTrainingErrorState(error.toString()));
          });
        }
      } else {
        // In case if a student ask to enroll but its already full.
        emit(RequestToEnrollTrainingErrorState('No Place in this Training'));
      }
    }).catchError((error) {
      emit(RequestToEnrollTrainingErrorState(error.toString()));
    });
  }

  void _getTrainingsCommentNumber() {
    try {
      TrainingApp.firestore
          .collection(TrainingApp.trainings)
          .snapshots()
          .listen((event) {
        for (var element in event.docs) {
          element.reference
              .collection(TrainingApp.comments)
              .snapshots()
              .listen((value) {
            commentNo[element.id] = value.docs.length;
          });
        }
      });
      emit(GetTrainingsCommentsSuccessState());
    } catch (error) {
      emit(GetTrainingsCommentsErrorState(error.toString()));
    }
  }

  void _getTrainingsStatus() {
    try {
      for (var training in trainings) {
        _getTrainingStatus(trainingId: training.id);
      }
      emit(GetTrainingsStatusSuccessState());
    } catch (error) {
      emit(GetTrainingsStatusErrorState(error.toString()));
    }
  }

  void _getTrainingStatus({required String trainingId}) {
    try {
      trainingStatus[trainingId] = TrainingStatus.NonDetermined;
      TrainingApp.firestore
          .collection(TrainingApp.trainings)
          .doc(trainingId)
          .collection(TrainingApp.enrollRequests)
          .snapshots()
          .listen((allRequests) {
        var doc =
            allRequests.docs.where((element) => element.id == uId).toList();
        if (doc.isNotEmpty) {
          if (doc[0][TrainingApp.studentId] == uId) {
            trainingStatus[trainingId] = TrainingStatus.Pending;
            emit(GetTrainingStatusSuccessState());
          }
        } else {
          TrainingApp.firestore
              .collection(TrainingApp.trainings)
              .doc(trainingId)
              .collection(TrainingApp.enrollments)
              .snapshots()
              .listen((allEnrolledStudents) {
            var doc = allEnrolledStudents.docs
                .where((element) => element.id == uId)
                .toList();
            if (doc.isNotEmpty) {
              if (doc[0][TrainingApp.studentId] == uId) {
                trainingStatus[trainingId] = TrainingStatus.Enrolled;
                emit(GetTrainingStatusSuccessState());
              }
            } else {
              trainingStatus[trainingId] = TrainingStatus.NonDetermined;
              emit(GetTrainingStatusSuccessState());
            }
          });
        }
      });
      TrainingApp.firestore
          .collection(TrainingApp.trainings)
          .doc(trainingId)
          .collection(TrainingApp.enrollments)
          .snapshots()
          .listen((allEnrolledStudents) {
        var doc = allEnrolledStudents.docs
            .where((element) => element.id == uId)
            .toList();
        if (doc.isNotEmpty) {
          if (doc[0][TrainingApp.studentId] == uId) {
            trainingStatus[trainingId] = TrainingStatus.Enrolled;
            emit(GetTrainingStatusSuccessState());
          }
        }
      });
    } catch (error) {
      emit(GetTrainingsStatusErrorState(error.toString()));
    }
  }

  void getEnrollmentsNotifications() {
    TrainingApp.firestore
        .collection(TrainingApp.student)
        .doc(student!.uId)
        .collection(TrainingApp.enrollmentsNotifications)
        .orderBy(TrainingApp.dateTime)
        .snapshots()
        .listen((event) {
      enrollmentNotifications = [];
      for (var element in event.docs) {
        enrollmentNotifications.add(EnrollmentNotification.fromJson(
          element.data(),
          element.id,
        ));
      }
      emit(GetTrainingsEnrollmentNotificationState());
    });
  }

  void getUploadedTrainingsNotifications() {
    TrainingApp.firestore
        .collection(TrainingApp.trainingNotifications)
        .orderBy(TrainingApp.dateTime)
        .snapshots()
        .listen((event) {
      uploadedTrainingNotifications = [];
      for (var element in event.docs) {
        uploadedTrainingNotifications.add(UploadedTrainingNotification.fromJson(
          element.data(),
          element.id,
        ));
      }
      emit(GetUploadedTrainingsNotificationState());
    });
  }

  bool isSubmitAllowed = false;

  void allowSubmitting(String value) {
    if (value.isNotEmpty) {
      isSubmitAllowed = true;
    } else {
      isSubmitAllowed = false;
    }
    emit(AppAllowingSendCommentState());
  }
}
