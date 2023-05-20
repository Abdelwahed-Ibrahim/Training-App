import '../config/config.dart';
import 'place_location.dart';

class Company {
  late String uId;
  late String name;
  late String email;
  late String phone;
  late String? avatarUrl;
  late Location? location;

  Company({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl =
        'https://firebasestorage.googleapis.com/v0/b/summertraining-1be92.appspot.com/o/company_profile.jpg?alt=media&token=6f7e7f24-12a3-4ac4-b4ab-ac843fbd630f',
    this.location,
  });

  Company.fromJSON(Map<String, dynamic>? json) {
    uId = json![TrainingApp.userUID];
    name = json[TrainingApp.userName];
    email = json[TrainingApp.userEmail];
    phone = json[TrainingApp.userPhone];
    avatarUrl = json[TrainingApp.userAvatarUrl] ??
        'https://firebasestorage.googleapis.com/v0/b/summertraining-1be92.appspot.com/o/company_profile.jpg?alt=media&token=6f7e7f24-12a3-4ac4-b4ab-ac843fbd630f';
    location = json[TrainingApp.location] != null
        ? Location.fromJSON(json[TrainingApp.location])
        : null;
  }

  Map<String, dynamic> toMap() {
    return {
      TrainingApp.userUID: uId,
      TrainingApp.userName: name,
      TrainingApp.userEmail: email,
      TrainingApp.userPhone: phone,
      TrainingApp.userAvatarUrl: avatarUrl,
      TrainingApp.location: location?.toMap(),
    };
  }
}
