import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

//ignore_for_file: non_constant_identifier_names
class TrainingApp {
  static const String appName = 'Training App';

  static String get API_KEY {
    return dotenv.env['GOOGLE_API_KEY'] ?? 'API_KEY Not Found';
  }

  static late SharedPreferences sharedPreferences;

  // static User? get user {
  //   return auth.currentUser;
  // }

  static User? user;
  static late FirebaseAuth auth;
  static late FirebaseFirestore firestore;
  static late FirebaseStorage firebaseStorage;
  static late FirebaseMessaging firebaseMessaging;
  static late Location myLocation;
  static late PolylinePoints polylinePoints;
  static late ImagePicker picker;

  static const String isCompany = 'is-company';
  static const String isProfileComplete = 'is-profile-complete';
  static const String company = 'Company';
  static const String student = 'Student';
  static const String completedProfile = 'complete-profile';
  static const String userUID = 'uid';
  static const String userName = 'name';
  static const String userEmail = 'email';
  static const String userPhone = 'phone';
  static const String userPassword = 'password';
  static const String userAvatarUrl = 'url';

  static const String location = 'location';
  static const String locationLatitude = 'latitude';
  static const String locationLongitude = 'longitude';
  static const String locationAddress = 'address';

  static const String commentsNotification = 'CommentsNotifications';
  static const String enrollRequestsNotification =
      'EnrollRequestsNotifications';
  static const String studentId = 'studentId';
  static const String studentName = 'studentName';
  static const String studentAvatarUrl = 'studentAvatarUrl';
  static const String trainingID = 'trainingId';
  static const String dateTime = 'dateTime';

  static const String trainingNotifications = 'TrainingNotifications';

  static const String trainings = 'Trainings';

  static const String trainingId = 'id';
  static const String companyName = 'companyName';
  static const String companyId = 'companyId';
  static const String isVerifiedCompany = 'isVerifiedCompany';
  static const String companyProfileImage = 'companyProfileImage';
  static const String trainingPostDate = 'trainingPostDate';
  static const String trainingTitle = 'trainingTitle';
  static const String trainingImage = 'trainingImage';
  static const String tags = 'tags';
  static const String rating = 'rating';
  static const String ratingStudent = 'ratingStudent';
  static const String requiredStudentNo = 'requiredStudentNo';
  static const String startingDate = 'startingDate';
  static const String totalHours = 'totalHours';
  static const String hoursPerWeek = 'hoursPerWeek';
  static const String description = 'description';
  static const String learnedTitles = 'learnedTitles';

  static const String comments = 'Comments';

  static const String commentUserName = 'userName';
  static const String userProfileImage = 'userProfileImage';
  static const String comment = 'comment';
  static const String commentDateTime = 'commentDateTime';

  static const String enrollRequests = 'EnrollRequests';

  static const String enrollments = 'Enrollments';
  static const String enrollmentsNotifications = 'EnrollmentsNotification';
  static const String studentTrainings = 'StudentTrainings';

  static const String category = 'category';
  static const String design = 'Design';
  static const String development = 'Development';
  static const String business = 'Business';
  static const String officeProductivity = 'Office Productivity';
  static const String financeAndAccounting = 'Finance & Accounting';
  static const String iTAndSoftware = 'IT & Software';
  static const String marketing = 'Marketing';
  static const String photography = 'Photography';

  // Firebase Cloud Messaging Topics
  static const String studentTopic = 'StudentTopic';
}
