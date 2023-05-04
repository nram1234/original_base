import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/widgets/chat/message_widgets/voice_record_message_widget.dart';
import 'package:original_base/src/ui/widgets/chat/message_widgets/image_message_widget.dart';
import 'package:original_base/src/ui/widgets/chat/message_widgets/text_message_widget.dart';
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/models/chat/chat_message.dart';
import 'package:original_base/src/core/utils/time_ago_util.dart';
import 'package:original_base/src/config/typography.dart';
//--------------------------------------------------------

class ChatMessageBubble extends StatelessWidget {
  final bool isRTL;
  final bool selfMessage;

  final ChatMessage chatMessage;

  const ChatMessageBubble({
    required this.isRTL,
    required this.selfMessage,
    required this.chatMessage,
  });

  TextDirection get textDirection {
    if (isRTL) {
      return selfMessage ? TextDirection.rtl : TextDirection.ltr;
    } else {
      return selfMessage ? TextDirection.ltr : TextDirection.rtl;
    }
  }

  Widget get messageWidget {
    if (chatMessage.imageUrl.isNotEmpty) {
      return ImageMessageWidget(
        chatMessage.imageUrl,
        chatMessage.senderName,
      );
    } else if (chatMessage.voiceUrl.isNotEmpty) {
      return VoiceRecordMessageWidget(
        selfMessage: selfMessage,
        recordUrl: chatMessage.voiceUrl,
        recordDurationInSeconds: chatMessage.durationInSeconds ?? 0,
      );
    } else {
      return TextMessageWidget(
        selfMessage: selfMessage,
        text: chatMessage.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        textDirection: this.textDirection,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(child: messageWidget),
          SizedBox(width: 8.0),
          Text(
            TimeAgoUtil(shortFormat: false).formatTime(
              chatMessage.sendDate,
              context.langCode,
            ),
            style: TextStyles.overline.copyWith(
              height: 1.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
