import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../shared/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool obscurePassword = true;

  IconData icon = Icons.visibility;

  void changeVisibility() {
    obscurePassword = !obscurePassword;
    icon = obscurePassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }

  final formKey = GlobalKey<FormState>();

  final Map<String, String> _formInputs = {};

  void saveUserEmail(email) {
    _formInputs[TrainingApp.userEmail] = email!.trim();
  }

  void saveUserPassword(password) {
    _formInputs[TrainingApp.userPassword] = password!;
  }

  Future<bool?> getIsCompany(String uId) async {
    try {
      var value = await TrainingApp.firestore
          .collection(TrainingApp.isCompany)
          .doc(uId)
          .get();
      emit(LoginGetAccountIsCompanySuccessState());
      if (value.data() == null) {
        return false;
      } else {
        return value.data()![TrainingApp.isCompany];
      }
    } catch (error) {
      emit(LoginGetAccountIsCompanyErrorState(error.toString()));
      return null;
    }
  }

  Future<bool?> getIsProfileComplete(String uId) async {
    try {
      var value = await TrainingApp.firestore
          .collection(TrainingApp.isProfileComplete)
          .doc(uId)
          .get();
      if (value.data() == null) {
        emit(LoginGetIsAccountCompletedSuccessState());
        return false;
      } else {
        emit(LoginGetIsAccountCompletedSuccessState());
        return value.data()![TrainingApp.isProfileComplete];
      }
    } catch (error) {
      emit(LoginGetIsAccountCompletedErrorState(error.toString()));
      return null;
    }
  }

  void cacheUserData(
      bool? isACompany, String? userId, bool? isProfileComplete) {
    CacheHelper.setData(
      key: TrainingApp.isCompany,
      value: isACompany,
    ).then((value) {
      isCompany = isACompany;
      emit(LoginCacheIsCompanySuccessState());
      CacheHelper.setData(
        key: TrainingApp.userUID,
        value: userId,
      ).then((value) {
        uId = userId;
        emit(LoginCacheUserIdSuccessState());
        CacheHelper.setData(
          key: TrainingApp.isProfileComplete,
          value: isProfileComplete,
        ).then((value) {
          isAccountComplete = isProfileComplete;
          emit(LoginCacheIsAccountCompletedSuccessState());
        }).catchError((error) {
          emit(LoginCacheIsAccountCompletedErrorState(error.toString()));
        });
      }).catchError((error) {
        emit(LoginCacheUserIdErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(LoginCacheIsCompanyErrorState(error.toString()));
    });
  }

  void trySignin() {
    emit(LoginLoadingState());
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      TrainingApp.auth
          .signInWithEmailAndPassword(
        email: _formInputs[TrainingApp.userEmail]!,
        password: _formInputs[TrainingApp.userPassword]!,
      )
          .then((value) async {
        var isACompany = await getIsCompany(value.user!.uid);
        var isProfileCompleted = await getIsProfileComplete(value.user!.uid);
        var userId = value.user!.uid;
        cacheUserData(isACompany, userId, isProfileCompleted);
        TrainingApp.user = value.user;
        emit(LoginSuccessState());
      }).catchError((error) {
        emit(LoginErrorState(error.message));
      });
    } else {
      emit(LoginErrorState('Not a valid form'));
    }
  }
}
