import 'package:hive/hive.dart';
//------------------------------
import 'package:original_base/src/config/hive_boxes.dart';
import 'package:original_base/src/core/models/user.dart';
//-------------------------------------------------------

class LoggedInUserHelper {
  Box _loggedInUserBox = HiveBoxes.loggedInUser;

  User? get storedUser {
    Map? storedCredentials = _loggedInUserBox.get("credentials");
    if (storedCredentials != null) {
      return User.fromJson(storedCredentials);
    } else {
      return null;
    }
  }

  Future<void> saveUserInfo(User user) async {
    await _loggedInUserBox.put("credentials", user.map);
  }

  Future<void> deleteUserInfo() async {
    await _loggedInUserBox.delete("credentials");
  }
}
