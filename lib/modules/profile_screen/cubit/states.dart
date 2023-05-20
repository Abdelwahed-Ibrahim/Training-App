abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class GetUserInfoLoadingState extends ProfileStates {}

class GetUserInfoSuccessState extends ProfileStates {}

class GetUserInfoErrorState extends ProfileStates {
  final String error;

  GetUserInfoErrorState(this.error);
}

class GetUserTrainingLoadingState extends ProfileStates {}

class GetUserTrainingSuccessState extends ProfileStates {}

class GetUserTrainingErrorState extends ProfileStates {
  final String error;

  GetUserTrainingErrorState(this.error);
}
