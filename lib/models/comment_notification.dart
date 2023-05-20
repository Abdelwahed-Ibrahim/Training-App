import '../config/config.dart';
import 'notification_model.dart';

class CommentNotification extends MyNotification {
  late final String studentId;
  late final String studentName;
  late final String studentAvatarUrl;

  CommentNotification.fromJson(
    Map<String, dynamic> json,
    String notificationId,
  ) {
    super.notificationId = notificationId;
    studentId = json[TrainingApp.studentId];
    studentName = json[TrainingApp.studentName];
    studentAvatarUrl = json[TrainingApp.studentAvatarUrl];
    trainingId = json[TrainingApp.trainingID];
    trainingImage = json[TrainingApp.trainingImage];
    dateTime = json[TrainingApp.dateTime];
  }

  Map<String, dynamic> toMap() {
    return {
      TrainingApp.studentId: studentId,
      TrainingApp.studentName: studentName,
      TrainingApp.studentAvatarUrl: studentAvatarUrl,
      TrainingApp.trainingID: trainingId,
      TrainingApp.trainingImage: trainingImage,
      TrainingApp.dateTime: dateTime,
    };
  }
}
