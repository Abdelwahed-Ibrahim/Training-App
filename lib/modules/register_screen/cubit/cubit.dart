// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../models/company.dart';
import '../../../models/student.dart';
import '../../../shared/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'states.dart';

// ignore: constant_identifier_names
enum AccountType { Company, Student }

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  IconData iconPass = Icons.visibility;
  IconData iconRePass = Icons.visibility;

  final formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  final Map<String, String> _formInputs = {};

  AccountType? accountType;

  void changePassVisibility() {
    obscurePassword = !obscurePassword;
    iconPass = obscurePassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }

  void changeConfirmPassVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    iconRePass =
        obscureConfirmPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }

  void changeAccountType(AccountType? value) {
    accountType = value;
    emit(RegisterChangeAccountTypeState());
  }

  void saveUserName(userName) {
    _formInputs[TrainingApp.userName] = userName!;
  }

  void saveUserEmail(email) {
    _formInputs[TrainingApp.userEmail] = email!.trim();
  }

  void saveUserPhone(phone) {
    _formInputs[TrainingApp.userPhone] = phone!.trim();
  }

  void saveUserPassword(password) {
    _formInputs[TrainingApp.userPassword] = password!;
  }

  void dispose() {
    passController.dispose();
  }

  @override
  Future<void> close() async {
    dispose();
    super.close();
  }

  void createUser({required String uId}) {
    Map<String, dynamic> account;
    if (accountType == AccountType.Company) {
      Company user = Company(
        uId: uId,
        name: _formInputs[TrainingApp.userName]!,
        email: _formInputs[TrainingApp.userEmail]!,
        phone: _formInputs[TrainingApp.userPhone]!,
      );
      account = user.toMap();
    } else {
      Student user = Student(
        uId: uId,
        name: _formInputs[TrainingApp.userName]!,
        email: _formInputs[TrainingApp.userEmail]!,
        phone: _formInputs[TrainingApp.userPhone]!,
      );
      account = user.toMap();
    }

    TrainingApp.firestore.collection(accountType!.name).doc(uId).set(account);
    TrainingApp.firestore.collection(TrainingApp.isCompany).doc(uId).set({
      TrainingApp.isCompany: accountType! == AccountType.Company,
    });
  }

  void cacheUserData(bool? isACompany, String? userId) {
    CacheHelper.setData(
      key: TrainingApp.isCompany,
      value: isACompany,
    ).then((value) {
      isCompany = isACompany;
      emit(RegisterCacheIsCompanySuccessState());
      CacheHelper.setData(
        key: TrainingApp.userUID,
        value: userId,
      ).then((value) {
        uId = userId;
        emit(RegisterCacheUserIdSuccessState());
        print(uId);
        print(isCompany);
      }).catchError((error) {
        emit(RegisterCacheUserIdErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(RegisterCacheIsCompanyErrorState(error.toString()));
    });
  }

  void tryRegister() {
    emit(RegisterLoadingState());
    if (formKey.currentState!.validate()) {
      if (accountType != null) {
        formKey.currentState!.save();
        TrainingApp.auth
            .createUserWithEmailAndPassword(
          email: _formInputs[TrainingApp.userEmail]!,
          password: _formInputs[TrainingApp.userPassword]!,
        )
            .then((value) {
          emit(RegisterSuccessState());
          try {
            createUser(uId: value.user!.uid);
            emit(RegisterCreateUserSuccessState());
            var isACompany = accountType == AccountType.Company;
            var userId = value.user!.uid;
            cacheUserData(isACompany, userId);
            TrainingApp.user = value.user;
          } catch (error) {
            emit(RegisterCreateUserErrorState(error.toString()));
          }
        }).catchError((error) {
          emit(RegisterErrorState(error.message));
        });
      } else {
        emit(RegisterErrorState(
            'Please select An account type(Company - Student)'));
      }
      print('The form inputs');
      print(_formInputs.toString());
    } else {
      emit(RegisterErrorState('Not a valid form'));
    }
  }
}
