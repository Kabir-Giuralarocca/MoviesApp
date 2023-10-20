import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  static const tokenKey = "token_key";

  static Future<String> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(tokenKey) ?? "";
  }

  static void saveToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(tokenKey, value);
  }

  static void removeToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(tokenKey);
  }
}
