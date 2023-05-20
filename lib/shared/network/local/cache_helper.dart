import '../../../config/config.dart';

class CacheHelper {
  // static Future<bool> setBoolean({
  //   required String key,
  //   required bool value,
  // }) async {
  //   return await SummerTrainingApp.sharedPreferences.setBool(key, value);
  // }

  // static bool? getBoolean({
  //   required String key,
  // }) {
  //   return SummerTrainingApp.sharedPreferences.getBool(key);
  // }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await TrainingApp.sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      return await TrainingApp.sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await TrainingApp.sharedPreferences.setDouble(key, value);
    }
    return await TrainingApp.sharedPreferences.setString(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return TrainingApp.sharedPreferences.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await TrainingApp.sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await TrainingApp.sharedPreferences.clear();
  }
}
