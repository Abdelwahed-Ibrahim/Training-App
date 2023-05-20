import '../config/config.dart';
import 'notification_model.dart';

class EnrollmentNotification extends MyNotification {
  late final String companyId;
  late final String companyName;
  late final String companyAvatarUrl;
  late final String trainingTitle;

  EnrollmentNotification.fromJson(
    Map<String, dynamic> json,
    String notificationId,
  ) {
    super.notificationId = notificationId;
    trainingId = json[TrainingApp.trainingID];
    trainingImage = json[TrainingApp.trainingImage];
    dateTime = json[TrainingApp.dateTime];
    companyId = json[TrainingApp.companyId];
    companyName = json[TrainingApp.companyName];
    companyAvatarUrl = json[TrainingApp.companyProfileImage];
    trainingTitle = json[TrainingApp.trainingTitle];
  }
}
