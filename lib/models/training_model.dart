import '../config/config.dart';
// import 'comment_model.dart';

class TrainingPostModel {
  late String id;
  late String companyName;
  late String companyId;
  late bool isVerifiedCompany;
  late String companyProfileImage;
  late String trainingPostDate;
  late String trainingTitle;
  late String trainingImage;
  late List<String> tags = [];
  late double rating;
  late int ratingStudent;
  late int requiredStudentNo;
  late String startingDate;
  late int totalHours;
  late int hoursPerWeek;
  late String description;
  late String category;
  late List<String> learnedTitles = [];

  TrainingPostModel({
    this.id = '-1',
    required this.companyName,
    required this.companyId,
    required this.isVerifiedCompany,
    required this.companyProfileImage,
    required this.trainingPostDate,
    required this.trainingTitle,
    required this.trainingImage,
    required this.tags,
    required this.requiredStudentNo,
    required this.startingDate,
    required this.totalHours,
    required this.hoursPerWeek,
    required this.description,
    required this.category,
    required this.learnedTitles,
    this.rating = 0.0,
    this.ratingStudent = 0,
  });

  TrainingPostModel.fromJSON(Map<String, dynamic> json, this.id) {
    companyName = json[TrainingApp.companyName];
    companyId = json[TrainingApp.companyId];
    isVerifiedCompany = json[TrainingApp.isVerifiedCompany];
    companyProfileImage = json[TrainingApp.companyProfileImage];
    trainingPostDate = json[TrainingApp.trainingPostDate];
    trainingTitle = json[TrainingApp.trainingTitle];
    trainingImage = json[TrainingApp.trainingImage];
    if (json[TrainingApp.tags] != null) {
      json[TrainingApp.tags].forEach((v) {
        tags.add(v);
      });
    }
    rating = json[TrainingApp.rating] ?? 0.0;
    ratingStudent = json[TrainingApp.ratingStudent] ?? 0;
    requiredStudentNo = json[TrainingApp.requiredStudentNo];
    startingDate = json[TrainingApp.startingDate];
    totalHours = json[TrainingApp.totalHours];
    hoursPerWeek = json[TrainingApp.hoursPerWeek];
    description = json[TrainingApp.description];
    category = json[TrainingApp.category];
    if (json[TrainingApp.learnedTitles] != null) {
      json[TrainingApp.learnedTitles].forEach((v) {
        learnedTitles.add(v);
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      TrainingApp.trainingId: id,
      TrainingApp.companyName: companyName,
      TrainingApp.companyId: companyId,
      TrainingApp.isVerifiedCompany: isVerifiedCompany,
      TrainingApp.companyProfileImage: companyProfileImage,
      TrainingApp.trainingPostDate: trainingPostDate,
      TrainingApp.trainingTitle: trainingTitle,
      TrainingApp.trainingImage: trainingImage,
      TrainingApp.tags: tags,
      TrainingApp.rating: rating,
      TrainingApp.ratingStudent: ratingStudent,
      TrainingApp.requiredStudentNo: requiredStudentNo,
      TrainingApp.startingDate: startingDate,
      TrainingApp.totalHours: totalHours,
      TrainingApp.hoursPerWeek: hoursPerWeek,
      TrainingApp.description: description,
      TrainingApp.category: category,
      TrainingApp.learnedTitles: learnedTitles,
    };
  }
}
