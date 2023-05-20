abstract class MyNotification {
  late final String notificationId;
  late final String trainingId;
  late final String trainingImage;
  late final String dateTime;

  static int compareNotifications(notification1, notification2) {
    return notification1.dateTime.compareTo(notification2.dateTime);
  }
}
