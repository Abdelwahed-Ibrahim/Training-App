import '../config/config.dart';
import 'place_location.dart';

class Student {
  late String uId;
  late String name;
  late String email;
  late String phone;
  late String? avatarUrl;
  late Location? location;

  Student({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl =
        'https://firebasestorage.googleapis.com/v0/b/summertraining-1be92.appspot.com/o/anonymous.jpg?alt=media&token=c04bbebe-6f9d-4356-a034-136855185b44',
    this.location,
  });

  Student.fromJSON(Map<String, dynamic>? json) {
    uId = json![TrainingApp.userUID];
    name = json[TrainingApp.userName];
    email = json[TrainingApp.userEmail];
    phone = json[TrainingApp.userPhone];
    avatarUrl = json[TrainingApp.userAvatarUrl] ??
        'https://firebasestorage.googleapis.com/v0/b/summertraining-1be92.appspot.com/o/anonymous.jpg?alt=media&token=c04bbebe-6f9d-4356-a034-136855185b44';
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
