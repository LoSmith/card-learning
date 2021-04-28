import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences instance;

  /// Needs to be called before using sharedPrefs
  static Future init() async {
    instance = await SharedPreferences.getInstance();
  }
}
