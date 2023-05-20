const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.myCommentNotificationFunction = functions.firestore
    .document("Company/{companyId}/CommentsNotifications/{notification}")
    .onCreate((snap, context) => {
      console.log(context.params.companyId);
      console.log(snap.data());
      return admin.messaging().sendToTopic(
          context.params.companyId,
          {
            notification:
            {
              title: snap.data().studentName,
              body: "Commented on your Training Post.",
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
          });
    });

exports.myEnrollRequestsNotificationFunction = functions.firestore
    .document("Company/{companyId}/EnrollRequestsNotifications/{notification}")
    .onCreate((snap, context) => {
      console.log(context.params.companyId);
      console.log(snap.data());
      const notification = snap.data();
      return admin.messaging().sendToTopic(
          context.params.companyId,
          {
            notification:
            {
              title: "You have a new Enroll Request",
              body: notification.studentName +
              " asks you to Enroll your Training.",
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
          });
    });

exports.myEnrollmentNotificationFunction = functions.firestore
    .document("Student/{studentId}/EnrollmentsNotification/{notification}")
    .onCreate((snap, context) => {
      const notification = snap.data();
      return admin.messaging().sendToTopic(
          context.params.studentId,
          {
            notification:
            {
              title: "Enroll Request Approved",
              body: notification.companyName +
              " approved to enroll this Training "+
              notification.trainingTitle,
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
          });
    });

exports.myNewTrainingNotificationFunction = functions.firestore
    .document("TrainingNotifications/{notification}")
    .onCreate((snap, context) => {
      return admin.messaging().sendToTopic(
          "StudentTopic",
          {
            notification:
            {
              title: "New Training",
              body: snap.data().companyName + " just added a new Training.",
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
          });
    });
