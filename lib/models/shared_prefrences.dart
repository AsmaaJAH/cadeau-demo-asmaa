import 'package:shared_preferences/shared_preferences.dart';

const stringTokenSharedPreference = "token";
const isLoggedInBoolSharedPreference = "isLoggedIn";  

class SharedPref {
  static Future setString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(stringTokenSharedPreference, value);
  }

  static Future<String> getString() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(stringTokenSharedPreference) ?? "";
  }
static Future setTrueBool() async {
   final prefs = await SharedPreferences.getInstance();
   prefs.setBool(isLoggedInBoolSharedPreference, true);
 }
 static Future<bool> getBool() async {
   final prefs = await SharedPreferences.getInstance();
   return prefs.getBool(isLoggedInBoolSharedPreference) ?? false;
 }
  static Future clearSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
