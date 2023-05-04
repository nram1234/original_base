import 'package:flutter/widgets.dart';
//------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
//-------------------------------------------------------------------------------------

class ChatMessage {
  late final int senderId;

  /// duration of audio record if this message is a voice record.
  late final int? durationInSeconds;

  late final String text;
  late final String imageUrl;
  late final String voiceUrl;
  late final String senderName;

  /// determines if this message was read by chat room members.
  late final Map read;

  late final DateTime sendDate;

  ChatMessage.fromMap(Map map) {
    senderId = map[("sender_id")];
    text = map["text"] ?? "";
    imageUrl = map["image"] ?? "";
    voiceUrl = map["voice"] ?? "";
    senderName = map["sender_name"];
    read = map["read"];
    sendDate = DateTime.fromMillisecondsSinceEpoch(map["date"] * 1000);
    durationInSeconds = map["duration"];
  }

  String toStringRepresentation(BuildContext context) {
    if (text.isNotEmpty) {
      return text;
    } else if (imageUrl.isNotEmpty) {
      return "$senderName " + "#sent_image".translate(context);
    } else {
      return "$senderName " + "#sent_voice".translate(context);
    }
  }
}
