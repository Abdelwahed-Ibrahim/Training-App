import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../models/comment_model.dart';
import 'states.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitialState());

  static PostCubit get(context) => BlocProvider.of(context);

  bool expandLearnedTitles = true;
  bool expandDescription = true;

  IconData learnedTitlesIcon = Icons.remove;
  IconData descriptionIcon = Icons.remove;

  void changeLearnedTitleVisibility() {
    expandLearnedTitles = !expandLearnedTitles;
    learnedTitlesIcon = expandLearnedTitles ? Icons.remove : Icons.add;
    emit(PostExpandLearnedTitlesState());
  }

  void changeDescriptionVisibility() {
    expandDescription = !expandDescription;
    descriptionIcon = expandDescription ? Icons.remove : Icons.add;
    emit(PostExpandLearnedTitlesState());
  }

  // TextEditingController commentController = TextEditingController();
  //
  // void dispose() {
  //   commentController.dispose();
  // }
  //
  // @override
  // Future<void> close() async {
  //   dispose();
  //   super.close();
  // }

  List<CommentModel> comments = [];

  void getTrainingPostComments(String trainingId) {
    emit(GetTrainingPostCommentsLoadingState());
    try {
      TrainingApp.firestore
          .collection(TrainingApp.trainings)
          .doc(trainingId)
          .collection(TrainingApp.comments)
          .orderBy(TrainingApp.commentDateTime)
          .snapshots()
          .listen((event) {
        comments = [];
        for (var element in event.docs) {
          comments.add(CommentModel.fromJSON(element.data()));
        }
        emit(GetTrainingPostCommentsSuccessState());
      });
    } catch (error) {
      emit(GetTrainingPostCommentsErrorState(error.toString()));
    }
  }

//   emit(UploadTrainingLoadingState());
//         try {
//           formKey.currentState!.save();
//           trainingImageURL = await uploadTrainingImage();
//           _formInputs[TrainingApp.trainingImage] = trainingImageURL!;
//           _formInputs[TrainingApp.companyName] = company!.name;
//           _formInputs[TrainingApp.companyId] = company!.uId;
//           _formInputs[TrainingApp.isVerifiedCompany] = isAccountComplete;
//           _formInputs[TrainingApp.companyProfileImage] = company!.avatarUrl;
//           _formInputs[TrainingApp.trainingPostDate] = DateTime.now().toString();
//           _formInputs[TrainingApp.tags] = tags;
//           _formInputs[TrainingApp.learnedTitles] = learnedTitles;
//           _getCategoryType();
//           TrainingPostModel post = TrainingPostModel.fromJSON(
//               _formInputs, Timestamp.now().toString());
//           //DateTime.now().toIso8601String(),
//           print(post.toMap());
//           await TrainingApp.firestore
//               .collection(TrainingApp.trainings)
//               .add(post.toMap());
//           emit(UploadTrainingSuccessState());
//         } catch (error) {
//           print('Error');
//           print(error.toString());
//           emit(UploadTrainingErrorState(error.toString()));
//         }
}
