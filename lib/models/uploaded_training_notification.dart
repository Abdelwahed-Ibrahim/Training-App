import '../config/config.dart';
import 'notification_model.dart';

class UploadedTrainingNotification extends MyNotification {
  late final String companyName;
  late final String trainingTitle;

  UploadedTrainingNotification.fromJson(
    Map<String, dynamic> json,
    String notificationId,
  ) {
    super.notificationId = notificationId;
    trainingId = json[TrainingApp.trainingID];
    trainingImage = json[TrainingApp.trainingImage];
    dateTime = json[TrainingApp.dateTime];
    companyName = json[TrainingApp.companyName];
    trainingTitle = json[TrainingApp.trainingTitle];
  }
}
