import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:original_base/src/core/services/local_storage/logged_in_user_helper.dart';
//----------------------------------------------------------------------------------------

class UserOnlineStatusClient {
  /// currently opened private chat room id.
  static String? openedChatRoomId;

  final _firestore = FirebaseFirestore.instance;
  final _loggedInUser = LoggedInUserHelper().storedUser;

  /// reference to "users_status" collection.
  CollectionReference get _usersStatus {
    return _firestore.collection("users_status");
  }

  /// reference to "chat_rooms" collection.
  CollectionReference get _chatRooms {
    return _firestore.collection("chat_rooms");
  }

  Stream<DocumentSnapshot> getPeerUserOnlineStatusStream(String peerId) {
    return _usersStatus.doc(peerId).snapshots();
  }

  Future<void> changeUserOnlineStatus(bool newBool) async {
    if (_loggedInUser != null) {
      String userId = _loggedInUser!.id.toString();

      // check if user status document exists and then
      // update or set it with new user online status.
      try {
        var userStatusDocRef = _usersStatus.doc(userId);
        var userStatusDoc = await userStatusDocRef.get();
        if (userStatusDoc.exists) {
          await userStatusDocRef.update({"online": newBool});
        } else {
          await userStatusDocRef.set({"online": newBool});
        }

        // change members_in_room status of currently opened chat room.
        if (openedChatRoomId != null) {
          _chatRooms.doc(openedChatRoomId).update({
            "members_in_room_status.$userId": newBool,
          });
        }
      } catch (_) {}
    }
  }
}
