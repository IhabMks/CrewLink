import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static const String USERLOGGEDINKEY = "LOGGEDINKEY";
  static const String USERFULLNAMEKEY = "USERNAMEKEY";
  static const String USEREMAILKEY = "USEREMAILKEY";

  // set the data from the Shared preferences
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(USERLOGGEDINKEY, isUserLoggedIn);
  }

  static Future<bool> saveUserFullName(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(USERFULLNAMEKEY, userName);
  }

  static Future<bool> saveUserEmail(String email) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(USEREMAILKEY, email);
  }

  // get the data from the Shared preferences
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(USERLOGGEDINKEY);
  }

  static Future<bool> clearUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(USERLOGGEDINKEY, false) &&
        await sf.setString(USERFULLNAMEKEY, "") &&
        await sf.setString(USEREMAILKEY, "");
  }
}
