import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../models/company.dart';
import '../../../models/student.dart';
import '../../../models/training_model.dart';
import '../../../shared/constants.dart';
import 'states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(BuildContext context) =>
      BlocProvider.of<ProfileCubit>(context);

  Student? student;
  Company? company;
  List<TrainingPostModel> userTrainings = [];

  void getUserInfo(String uId) {
    emit(GetUserInfoLoadingState());
    isCompany == true
        ? TrainingApp.firestore
            .collection(TrainingApp.student)
            .doc(uId)
            .get()
            .then((value) {
            student = Student.fromJSON(value.data());
            getUserTraining(uId);
            emit(GetUserInfoSuccessState());
          }).catchError((error) {
            emit(GetUserInfoErrorState(error.toString()));
          })
        : TrainingApp.firestore
            .collection(TrainingApp.company)
            .doc(uId)
            .get()
            .then((value) {
            company = Company.fromJSON(value.data());
            getUserTraining(uId);
            emit(GetUserInfoSuccessState());
          }).catchError((error) {
            emit(GetUserInfoErrorState(error.toString()));
          });
  }

  void getUserTraining(String uId) {
    emit(GetUserTrainingLoadingState());
    isCompany == true
        ? TrainingApp.firestore
            .collection(TrainingApp.student)
            .doc(student!.uId)
            .collection(TrainingApp.studentTrainings)
            .get()
            .then((value) {
            userTrainings = [];
            for (var trainingId in value.docs) {
              TrainingApp.firestore
                  .collection(TrainingApp.trainings)
                  .doc(trainingId.id)
                  .get()
                  .then((training) {
                userTrainings.add(
                    TrainingPostModel.fromJSON(training.data()!, training.id));
                emit(GetUserTrainingSuccessState());
              });
            }
          }).catchError((error) {
            emit(GetUserTrainingErrorState(error.toString()));
          })
        : TrainingApp.firestore
            .collection(TrainingApp.trainings)
            .orderBy(TrainingApp.trainingId)
            .where(TrainingApp.companyId, isEqualTo: company!.uId)
            .get()
            .then((value) {
            userTrainings = [];
            for (var element in value.docs) {
              userTrainings
                  .add(TrainingPostModel.fromJSON(element.data(), element.id));
              emit(GetUserTrainingSuccessState());
            }
          }).catchError((error) {
            emit(GetUserTrainingErrorState(error.toString()));
          });
  }
}
