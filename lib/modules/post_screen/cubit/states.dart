abstract class PostStates {}

class PostInitialState extends PostStates {}

class PostExpandLearnedTitlesState extends PostStates {}

class PostExpandDescriptionState extends PostStates {}

class GetTrainingPostCommentsLoadingState extends PostStates {}

class GetTrainingPostCommentsSuccessState extends PostStates {}

class GetTrainingPostCommentsErrorState extends PostStates {
  final String error;

  GetTrainingPostCommentsErrorState(this.error);
}
