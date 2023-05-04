import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:original_base/src/core/services/local_storage/logged_in_user_helper.dart';
//----------------------------------------------------------------------------------------

class PushTokenClient {
  final _firestore = FirebaseFirestore.instance;
  final _loggedInUser = LoggedInUserHelper().storedUser;

  /// reference to users_status collection on firestore.
  CollectionReference get _usersStatus {
    return _firestore.collection("users_status");
  }

  Future<void> updateUserPushToken(String newToken) async {
    if (_loggedInUser != null) {
      String userId = _loggedInUser!.id.toString();

      // check if user status document exists and then
      // update or set it with new push token.
      var userStatusDocRef = _usersStatus.doc(userId);
      var userStatusDoc = await userStatusDocRef.get();
      if (userStatusDoc.exists) {
        await userStatusDocRef.update({"push_token": newToken});
      } else {
        await userStatusDocRef.set({"push_token": newToken});
      }
    }
  }
}
