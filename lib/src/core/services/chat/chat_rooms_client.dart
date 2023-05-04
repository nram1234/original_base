import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:original_base/src/core/services/shared/user_online_status_client.dart';
import 'package:original_base/src/core/services/local_storage/logged_in_user_helper.dart';
//------------------------------------------------------------------------------------

class ChatRoomsClient {
  /// number of chat rooms retrieved per page
  static const int roomsPerPage = 30;

  final _firestore = FirebaseFirestore.instance;
  final _loggedInUser = LoggedInUserHelper().storedUser!;

  /// reference to all chat rooms created by users.
  CollectionReference get _chatRooms => _firestore.collection("chat_rooms");

  Query get chatRoomsQuery {
    return _chatRooms
        .where("members_ids_array", arrayContains: _loggedInUser.id)
        .where("last_message.date", isNull: false)
        .orderBy("last_message.date");
  }

  String getPeerId(Map membersIds) {
    List idsList = membersIds.keys.toList();
    String peerId = idsList.first == _loggedInUser.id.toString()
        ? idsList.last
        : idsList.first;
    return peerId;
  }

  Stream<DocumentSnapshot> getPeerUserOnlineStream(Map membersIds) {
    String peerId = getPeerId(membersIds);
    return UserOnlineStatusClient().getPeerUserOnlineStatusStream(peerId);
  }

  Stream<QuerySnapshot> getUnreadMessagesStream(String chatRoomId) {
    String userId = _loggedInUser.id.toString();
    return _chatRooms
        .doc(chatRoomId)
        .collection("messages")
        .where("read.$userId", isEqualTo: false)
        .snapshots();
  }
}
