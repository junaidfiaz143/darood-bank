import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/utilities.dart';

class LoginService {
  static saveUserData(dynamic data) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("userData");
    List<String> userData = [];
    userData.insert(0, data["full_name"]);
    userData.insert(1, data["username"]);
    userData.insert(2, data["is_official"].toString());
    userData.insert(3, data["phone_number"]);
    userData.insert(4, data["city"]);
    userData.insert(5, data["password"]);
    userData.insert(6, data["gender"]);

    _preferences.setStringList("userData", userData);
  }

  static deleteUserData() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    Utilities.duroodLockService(serviceAction: Constants.keyStop);
    Utilities.setPrefrences("DUROOD_PREFERENCE", false);
    _preferences.remove("userData");
  }

  static Future<List<String>?> loadUserData() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    if (_preferences.getStringList('userData') != null) {
      return _preferences.getStringList('userData');
    } else {
      return null;
    }
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getStringList('userData') != null;
  }
}
