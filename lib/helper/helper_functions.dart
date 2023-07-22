import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static const String USERLOGGEDINKEY = "LOGGEDINKEY";
  static const String USERNAMEKEY = "USERNAMEKEY";
  static const String USEREMAILKEY = "USEREMAILKEY";

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(USERLOGGEDINKEY);
  }
}
