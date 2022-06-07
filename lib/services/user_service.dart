import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  static Future<String?> readUserName () async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('user'); 
    return userName?? '';
  }

}