import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:original_base/src/core/models/chat/chat_message.dart';
//--------------------------------------------------------------------

class ChatRoom {
  /// unique id of this chat room on firestore.
  late final String uid;

  late final Map membersIds;
  late final Map membersNames;

  late final ChatMessage lastMessage;

  ChatRoom.fromDocument(DocumentSnapshot document) {
    uid = document.id;
    membersIds = document["members_ids_map"];
    membersNames = document["members_names"];
    lastMessage = ChatMessage.fromMap(document["last_message"]);
  }
}
