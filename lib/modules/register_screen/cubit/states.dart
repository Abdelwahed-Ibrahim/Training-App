abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class RegisterChangeAccountTypeState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterCreateUserSuccessState extends RegisterStates {}

class RegisterCreateUserErrorState extends RegisterStates {
  final String error;

  RegisterCreateUserErrorState(this.error);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterCacheIsCompanySuccessState extends RegisterStates {}

class RegisterCacheIsCompanyErrorState extends RegisterStates {
  final String error;

  RegisterCacheIsCompanyErrorState(this.error);
}

class RegisterCacheUserIdSuccessState extends RegisterStates {}

class RegisterCacheUserIdErrorState extends RegisterStates {
  final String error;

  RegisterCacheUserIdErrorState(this.error);
}
