abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginGetAccountIsCompanySuccessState extends LoginStates {}

class LoginGetAccountIsCompanyErrorState extends LoginStates {
  final String error;

  LoginGetAccountIsCompanyErrorState(this.error);
}

class LoginCacheIsCompanySuccessState extends LoginStates {}

class LoginCacheIsCompanyErrorState extends LoginStates {
  final String error;

  LoginCacheIsCompanyErrorState(this.error);
}

class LoginCacheUserIdSuccessState extends LoginStates {}

class LoginCacheUserIdErrorState extends LoginStates {
  final String error;

  LoginCacheUserIdErrorState(this.error);
}

class LoginGetIsAccountCompletedSuccessState extends LoginStates {}

class LoginGetIsAccountCompletedErrorState extends LoginStates {
  final String error;

  LoginGetIsAccountCompletedErrorState(this.error);
}

class LoginCacheIsAccountCompletedSuccessState extends LoginStates {
  // final bool? isAccountCompleted;
  //
  // LoginCacheIsAccountCompletedSuccessState(this.isAccountCompleted);
}

class LoginCacheIsAccountCompletedErrorState extends LoginStates {
  final String error;

  LoginCacheIsAccountCompletedErrorState(this.error);
}
