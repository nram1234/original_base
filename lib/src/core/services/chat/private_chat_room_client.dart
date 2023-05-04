import 'package:flutter_sound/flutter_sound.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:original_base/src/core/services/local_storage/logged_in_user_helper.dart';
import 'package:original_base/src/core/utils/assets_bytes_converter.dart';
//------------------------------------------------------------------------

class PrivateChatRoomClient {
  /// number of chat messages retrieved per page
  static const int messagesPerPage = 40;

  static const String _messageReceiveSound = "audio/message_received_sound.mp3";

  final String chatRoomId;

  final _firestore = FirebaseFirestore.instance;
  final _loggedInUser = LoggedInUserHelper().storedUser!;
  final _audioPlayer = FlutterSoundPlayer();

  PrivateChatRoomClient(this.chatRoomId) {
    _audioPlayer.openPlayer();
  }

  /// reference to all chat rooms created by users.
  CollectionReference get _chatRooms => _firestore.collection("chat_rooms");

  /// reference to all chat messages in the current room.
  CollectionReference get _chatMessages {
    return _chatRooms.doc(chatRoomId).collection("messages");
  }

  Query get chatMessagesQuery {
    return _chatMessages.orderBy("date", descending: true);
  }

  Future<String> sendMessage({
    int? durationInSeconds,
    required String peerId,
    required String message,
    required String messageType,
  }) async {
    // determine if the peer user is currently opening this chat room.
    DocumentSnapshot chatRoom = await _chatRooms.doc(chatRoomId).get();
    bool peerUserInChatRoom = chatRoom.get("members_in_room_status.$peerId");

    Map<String, dynamic> newMessage = {
      "date": Timestamp.now().seconds,
      if (durationInSeconds != null) "duration": durationInSeconds,
      "read": {
        "${_loggedInUser.id}": true,
        peerId: peerUserInChatRoom,
      },
      "sender_id": _loggedInUser.id,
      "sender_name": _loggedInUser.name,
      "recipient_id": peerId,
      "$messageType": message.trim(),
    };

    var newMessageDocumentRef = await _chatMessages.add(newMessage);

    /// don't update last message if message type is not text
    /// because it will get updated eventually after voice record
    /// or photo url is uploaded to firestore.
    if (messageType == "text") {
      await _chatRooms.doc(chatRoomId).update({
        "last_message": newMessage,
      });
    }

    return newMessageDocumentRef.id;
  }

  Future<void> updateMediaMessageUrl({
    required String messageDocumentId,
    required String mediaFileUrl,
    required String typeName,
  }) async {
    await _chatMessages.doc(messageDocumentId).update({
      "$typeName": mediaFileUrl,
    });

    var updatedMessage = await _chatMessages.doc(messageDocumentId).get();
    await _chatRooms.doc(chatRoomId).update({
      "last_message": updatedMessage.data(),
    });
  }

  void deleteMessage(String messageDocumentId) {
    _chatMessages.doc(messageDocumentId).delete();
  }

  void changeMemberOnRoomStatus(bool newBool) {
    _chatRooms.doc(chatRoomId).update({
      "members_in_room_status.${_loggedInUser.id}": newBool,
    });
  }

  void setMessageToRead(DocumentSnapshot messageDocument) {
    String userId = _loggedInUser.id.toString();
    if (messageDocument.get("read.$userId") == false) {
      convertAssetFileToUnit8List(_messageReceiveSound).then((soundBuffer) {
        _audioPlayer.startPlayer(fromDataBuffer: soundBuffer);
      });
      _chatMessages.doc(messageDocument.id).update({
        "read.$userId": true,
      });
    }
  }

  void disposePlayer() => _audioPlayer.closePlayer();
}
