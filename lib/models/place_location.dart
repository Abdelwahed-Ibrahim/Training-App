import '../config/config.dart';

class Location {
  late double latitude;
  late double longitude;
  late String? address;

  Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  Location.fromJSON(Map<String, dynamic> json) {
    latitude = json[TrainingApp.locationLatitude];
    longitude = json[TrainingApp.locationLongitude];
    address = json[TrainingApp.locationAddress];
  }

  Map<String, dynamic> toMap() {
    return {
      TrainingApp.locationLatitude: latitude,
      TrainingApp.locationLongitude: longitude,
      TrainingApp.locationAddress: address,
    };
  }
}
