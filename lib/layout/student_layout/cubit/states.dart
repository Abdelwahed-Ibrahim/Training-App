abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeNavBarState extends AppStates {}

class AppAllowingSendCommentState extends AppStates {}

class GetStudentInfoLoadingState extends AppStates {}

class GetStudentInfoSuccessState extends AppStates {}

class GetStudentInfoErrorState extends AppStates {
  final String error;

  GetStudentInfoErrorState(this.error);
}

class GetTrainingsPostsLoadingState extends AppStates {}

class GetTrainingsPostsSuccessState extends AppStates {}

class GetTrainingsPostsErrorState extends AppStates {
  final String error;

  GetTrainingsPostsErrorState(this.error);
}

class SearchTrainingsPostsSuccessState extends AppStates {}

class SearchTrainingsPostsErrorState extends AppStates {
  final String error;

  SearchTrainingsPostsErrorState(this.error);
}

class GetMyTrainingsPostsLoadingState extends AppStates {}

class GetMyTrainingsPostsSuccessState extends AppStates {}

class GetMyTrainingsPostsErrorState extends AppStates {
  final String error;

  GetMyTrainingsPostsErrorState(this.error);
}

class WritingTrainingCommentSuccessState extends AppStates {}

class WritingTrainingCommentErrorState extends AppStates {
  final String error;

  WritingTrainingCommentErrorState(this.error);
}

class RequestToEnrollTrainingSuccessState extends AppStates {}

class RemoveRequestToEnrollOnTrainingState extends AppStates {}

class RequestToEnrollTrainingErrorState extends AppStates {
  final String error;

  RequestToEnrollTrainingErrorState(this.error);
}

class SendCompanyNotificationSuccessState extends AppStates {}

class SendCompanyNotificationErrorState extends AppStates {
  final String error;

  SendCompanyNotificationErrorState(this.error);
}

class RemoveCompanyNotificationSuccessState extends AppStates {}

class RemoveCompanyNotificationErrorState extends AppStates {
  final String error;

  RemoveCompanyNotificationErrorState(this.error);
}

class GetTrainingsCommentsSuccessState extends AppStates {}

class GetTrainingsCommentsErrorState extends AppStates {
  final String error;

  GetTrainingsCommentsErrorState(this.error);
}

class GetTrainingsStatusSuccessState extends AppStates {}

class GetTrainingsStatusErrorState extends AppStates {
  final String error;

  GetTrainingsStatusErrorState(this.error);
}

class GetTrainingStatusSuccessState extends AppStates {}

class GetTrainingStatusErrorState extends AppStates {
  final String error;

  GetTrainingStatusErrorState(this.error);
}

class GetTrainingsEnrollmentNotificationState extends AppStates {}

class GetUploadedTrainingsNotificationState extends AppStates {}
