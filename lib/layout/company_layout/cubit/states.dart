abstract class LayoutStates {}

// Layout Page

class LayoutInitialState extends LayoutStates {}

class LayoutChangeScreenState extends LayoutStates {}

class GetCompanyInfoLoadingState extends LayoutStates {}

class GetCompanyInfoSuccessState extends LayoutStates {}

class GetCompanyInfoErrorState extends LayoutStates {
  final String error;

  GetCompanyInfoErrorState(this.error);
}

// Upload Training Page

class PickDateState extends LayoutStates {}

class AllowingSendSubmitState extends LayoutStates {}

class AddTagState extends LayoutStates {}

class TagsEmptyErrorState extends LayoutStates {
  final String error;

  TagsEmptyErrorState(this.error);
}

class AddLearnedTitleState extends LayoutStates {}

class LearnedTitlesEmptyErrorState extends LayoutStates {
  final String error;

  LearnedTitlesEmptyErrorState(this.error);
}

class PickTrainingImageLoadingState extends LayoutStates {}

class PickTrainingImageSuccessState extends LayoutStates {}

class PickTrainingImageErrorState extends LayoutStates {
  final String error;

  PickTrainingImageErrorState(this.error);
}

class NoSelectedImageErrorState extends LayoutStates {
  final String error;

  NoSelectedImageErrorState(this.error);
}

class RemovePickedImageState extends LayoutStates {}

class ChangeCategoryTypeState extends LayoutStates {}

class NoCategoryTypeSelectedState extends LayoutStates {
  final String error;

  NoCategoryTypeSelectedState(this.error);
}

class UploadTrainingImageLoadingState extends LayoutStates {}

class UploadTrainingImageSuccessState extends LayoutStates {}

class UploadTrainingImageErrorState extends LayoutStates {
  final String error;

  UploadTrainingImageErrorState(this.error);
}

class GetTrainingImageLinkSuccessState extends LayoutStates {}

class GetTrainingImageLinkErrorState extends LayoutStates {
  final String error;

  GetTrainingImageLinkErrorState(this.error);
}

class UploadTrainingLoadingState extends LayoutStates {}

class UploadTrainingSuccessState extends LayoutStates {}

class UploadTrainingErrorState extends LayoutStates {
  final String error;

  UploadTrainingErrorState(this.error);
}

class GetMyTrainingsPostsLoadingState extends LayoutStates {}

class WritingTrainingCommentSuccessState extends LayoutStates {}

class WritingTrainingCommentErrorState extends LayoutStates {
  final String error;

  WritingTrainingCommentErrorState(this.error);
}

class GetMyTrainingsCommentNotificationState extends LayoutStates {}

class GetMyTrainingsEnrolmentRequestNotificationState extends LayoutStates {}

class GetMyTrainingsPostsSuccessState extends LayoutStates {}

class GetMyTrainingsPostsErrorState extends LayoutStates {
  final String error;

  GetMyTrainingsPostsErrorState(this.error);
}

class AddStudentToATrainingSuccessState extends LayoutStates {}

class AddStudentToATrainingErrorState extends LayoutStates {
  final String error;

  AddStudentToATrainingErrorState(this.error);
}
