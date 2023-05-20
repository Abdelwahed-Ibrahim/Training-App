import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../config/config.dart';
import '../../../models/company.dart';
import '../../../models/place_location.dart';
import '../../../models/student.dart';
import '../../../shared/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'states.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileStates> {
  CompleteProfileCubit() : super(CompleteProfileInitialState());

  static CompleteProfileCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Student? student;
  Company? company;
  String? name;
  String? email;
  String? phone;
  String? avatarURL;
  Location? location;

  bool allowEditingName = false;
  bool allowEditingEmail = false;
  bool allowEditingPhone = false;

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Future<void> close() async {
    dispose();
    super.close();
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  void allowingEditName() {
    allowEditingName = true;
    nameController.text = name!;
    emit(CompleteProfileChangeNameState());
  }

  void allowingEditEmail() {
    allowEditingEmail = true;
    emailController.text = email!;
    emit(CompleteProfileChangeEmailState());
  }

  void allowingEditPhone() {
    allowEditingPhone = true;
    phoneController.text = phone!;
    emit(CompleteProfileChangePhoneState());
  }

  void savingMyName() {
    if (formKey.currentState!.validate()) {
      allowEditingName = false;
      name = nameController.text;
      emit(CompleteProfileChangedNameState());
    }
  }

  void savingMyPhone() {
    if (formKey.currentState!.validate()) {
      allowEditingPhone = false;
      phone = phoneController.text;
      emit(CompleteProfileChangedPhoneState());
    }
  }

  void savingMyEmail() {
    if (formKey.currentState!.validate()) {
      allowEditingEmail = false;
      email = emailController.text;
      emit(CompleteProfileChangedEmailState());
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      final locData = await TrainingApp.myLocation.getLocation();
      // ToDo: Get Address From Google APIs
      var url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${locData.latitude},${locData.longitude}&key=${TrainingApp.API_KEY}';
      http.get(Uri.parse(url)).then((value) {
        location = Location(
            latitude: locData.latitude!,
            longitude: locData.longitude!,
            address: json.decode(value.body)['results'][0]
                ['formatted_address']);
        emit(CompleteProfileGetLocationSuccessState());
      }).catchError((error) {
        emit(CompleteProfileGetLocationErrorState(error.toString()));
      });
    } catch (error) {
      emit(CompleteProfileGetLocationErrorState(error.toString()));
      return;
    }
  }

  File? profileImage;

  Future<void> pickProfileImage() async {
    emit(PickProfileImageLoadingState());
    final pickedFile =
        await TrainingApp.picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      emit(PickProfileImageErrorState('No Image Selected'));
    }
  }

  Future<void> postMyProfileInfo() async {
    if (name != null &&
        email != null &&
        phone != null &&
        location != null &&
        (profileImage != null || isAccountComplete == true)) {
      var value = (isAccountComplete == true && profileImage == null)
          ? null
          : await uploadProfileImage();
      if (isCompany == true) {
        company = Company(
            uId: uId!,
            name: name!,
            email: email!,
            phone: phone!,
            avatarUrl: value ?? avatarURL,
            location: location);
      } else if (isCompany == false) {
        student = Student(
            uId: uId!,
            name: name!,
            email: email!,
            phone: phone!,
            avatarUrl: value ?? avatarURL,
            location: location);
      }
      TrainingApp.firestore
          .collection(
              isCompany == true ? TrainingApp.company : TrainingApp.student)
          .doc(uId)
          .update(isCompany == true ? company!.toMap() : student!.toMap())
          .then((value) async {
        await CacheHelper.setData(
            key: TrainingApp.isProfileComplete, value: true);
        await TrainingApp.firestore
            .collection(TrainingApp.isProfileComplete)
            .doc(uId)
            .set({
          TrainingApp.isProfileComplete: true,
        });
        emit(CompleteProfileSuccessState());
        //ToDo : cache profile is completed
      }).catchError((error) {
        emit(CompleteProfileErrorState(error.toString()));
      });
    }
  }

  Future<String?> uploadProfileImage() async {
    String msg = '';
    try {
      emit(UploadProfileImageLoadingState());
      if (profileImage != null) {
        var value = await TrainingApp.firebaseStorage
            .ref()
            .child(
                'users/$uId/${Uri.file(profileImage!.path).pathSegments.last}')
            .putFile(profileImage!);
        msg = 'upload success';
        emit(UploadProfileImageSuccessState());
        var url = await value.ref.getDownloadURL();
        avatarURL = url;
        msg = 'getting image url success';
        emit(GetProfileImageLinkSuccessState());
        return url;
      }
    } catch (error) {
      if (msg == 'upload success') {
        emit(GetProfileImageLinkErrorState(error.toString()));
      } else {
        emit(UploadProfileImageErrorState(error.toString()));
      }
    }
    return null;
  }

  Future<bool> getIsProfileCompleted(bool openAsSettings) async {
    bool? value = await CacheHelper.getData(key: TrainingApp.isProfileComplete);
    if (value != true) {
      //value is equal to false profile is not completed or null
      getUserInfo();
      return false;
    } else {
      if (openAsSettings) {
        getUserInfo();
      }
      emit(CompleteProfileSuccessState());
      return true;
    }
  }

  void getUserInfo() {
    emit(CompleteProfileGetUserInfoLoadingState());
    TrainingApp.firestore
        .collection(
            isCompany == true ? TrainingApp.company : TrainingApp.student)
        .doc(uId)
        .get()
        .then((value) {
      name = value.data()![TrainingApp.userName];
      email = value.data()![TrainingApp.userEmail];
      phone = value.data()![TrainingApp.userPhone];
      avatarURL = value.data()![TrainingApp.userAvatarUrl];
      location = value.data()![TrainingApp.location] != null
          ? Location.fromJSON(value.data()![TrainingApp.location])
          : null;
      emit(CompleteProfileGetUserInfoSuccessState());
    }).catchError((error) {
      emit(CompleteProfileGetUserInfoErrorState(error.toString()));
    });
  }
}
