abstract class CompleteProfileStates {}

class CompleteProfileInitialState extends CompleteProfileStates {}

class CompleteProfileGetUserInfoLoadingState extends CompleteProfileStates {}

class CompleteProfileGetUserInfoSuccessState extends CompleteProfileStates {}

class CompleteProfileGetUserInfoErrorState extends CompleteProfileStates {
  final String error;

  CompleteProfileGetUserInfoErrorState(this.error);
}

class CompleteProfileGetLocationSuccessState extends CompleteProfileStates {}

class CompleteProfileGetLocationErrorState extends CompleteProfileStates {
  final String error;

  CompleteProfileGetLocationErrorState(this.error);
}

class PickProfileImageLoadingState extends CompleteProfileStates {}

class PickProfileImageSuccessState extends CompleteProfileStates {}

class PickProfileImageErrorState extends CompleteProfileStates {
  final String error;

  PickProfileImageErrorState(this.error);
}

class UploadProfileImageLoadingState extends CompleteProfileStates {}

class UploadProfileImageSuccessState extends CompleteProfileStates {}

class UploadProfileImageErrorState extends CompleteProfileStates {
  final String error;

  UploadProfileImageErrorState(this.error);
}

class GetProfileImageLinkSuccessState extends CompleteProfileStates {}

class GetProfileImageLinkErrorState extends CompleteProfileStates {
  final String error;

  GetProfileImageLinkErrorState(this.error);
}

class CompleteProfileChangeNameState extends CompleteProfileStates {}

class CompleteProfileChangedNameState extends CompleteProfileStates {}

class CompleteProfileChangeEmailState extends CompleteProfileStates {}

class CompleteProfileChangedEmailState extends CompleteProfileStates {}

class CompleteProfileChangePhoneState extends CompleteProfileStates {}

class CompleteProfileChangedPhoneState extends CompleteProfileStates {}

class CompleteProfileLoadingState extends CompleteProfileStates {}

class CompleteProfileSuccessState extends CompleteProfileStates {}

class CompleteProfileErrorState extends CompleteProfileStates {
  final String error;

  CompleteProfileErrorState(this.error);
}
