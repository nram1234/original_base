import 'dart:async';
//------------------
import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:original_base/src/core/services/local_storage/logged_in_user_helper.dart';
import 'package:original_base/src/core/models/user.dart';
//-------------------------------------------------------

class NewChatRoomClient {
  final _firestore = FirebaseFirestore.instance;
  final _loggedInUser = LoggedInUserHelper().storedUser!;

  /// reference to all chat rooms created by users.
  CollectionReference get _chatRooms => _firestore.collection("chat_rooms");

  /// reference to "users_status" collection.
  CollectionReference get _usersStatus {
    return _firestore.collection("users_status");
  }

  Future<String> startNewChatRoom(User peer) async {
    bool peerIsOnline = await _checkPeerUserOnlineStatus(peer.id);
    var newChatRoomDocument = await _chatRooms.add({
      "members_ids_map": {
        _loggedInUser.id.toString(): true,
        peer.id.toString(): true,
      },
      "members_ids_array": [_loggedInUser.id, peer.id],
      "members_in_room_status": {
        "${_loggedInUser.id}": true,
        "${peer.id}": peerIsOnline,
      },
      "members_names": {
        "${_loggedInUser.id}": _loggedInUser.name,
        "${peer.id}": peer.name,
      },
    });

    return newChatRoomDocument.id;
  }

  Future<String?> getExistingRoomId(int peerId) async {
    var results = await _chatRooms
        .where("members_ids_map.${_loggedInUser.id}", isEqualTo: true)
        .where("members_ids_map.$peerId", isEqualTo: true)
        .get();

    if (results.docs.isNotEmpty) {
      return results.docs.first.id;
    } else {
      return null;
    }
  }

  Future<bool> _checkPeerUserOnlineStatus(int peerId) async {
    var userStatusDoc = await _usersStatus.doc("$peerId").get();
    return userStatusDoc.exists && userStatusDoc.get("online");
  }
}
