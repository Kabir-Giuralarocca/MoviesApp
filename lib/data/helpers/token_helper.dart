import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  static const tokenKey = "token_key";

  static String get token {
    getToken().then((value) {
      return value;
    });
    return "";
  }

  static Future<String> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(tokenKey) ?? "";
  }

  static void saveToken(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(tokenKey, token);
  }
}
