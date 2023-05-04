import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/view_models/chat/private_chat_room_notifier.dart';
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/services/chat/private_chat_room_client.dart';
import 'package:original_base/src/ui/widgets/input/original_text_field.dart';
import 'package:original_base/src/core/utils/numeral_extensions.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ChatRoomBottomBar extends StatelessWidget {
  final String peerId;

  final PrivateChatRoomClient client;
  final PrivateChatRoomNotifier notifier;

  const ChatRoomBottomBar({
    required this.peerId,
    required this.client,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            SharedStyles.mediumComponentsRadius,
          ),
          topRight: Radius.circular(
            SharedStyles.mediumComponentsRadius,
          ),
        ),
        boxShadow: [SharedStyles.sharedShadow],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.0),
        child: Consumer(
          builder: (_, watch, __) {
            var watcher = watch(privateChatRoomProvider(client));
            bool textMode = watcher.showSendButton;
            bool isRecording = watcher.isRecording;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: isRecording ? "cancel_record" : "camera",
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  focusElevation: 0.0,
                  highlightElevation: 0.0,
                  hoverElevation: 0.0,
                  child: isRecording
                      ? Icon(
                          Icons.delete_forever,
                          size: 22.0,
                          color: Palette.burntSienna,
                        )
                      : SvgPicture.asset(
                          "assets/icons/camera.svg",
                          height: 22.0,
                          width: 22.0,
                        ),
                  onPressed: () {
                    notifier.isRecording
                        ? notifier.cancelAudioRecording()
                        : notifier.sendImageMessage(context, peerId: peerId);
                  },
                ),
                SizedBox(width: 5.0),
                Flexible(
                  child: Stack(
                    children: [
                      OriginalTextField(
                        enabled: !isRecording,
                        hintText: "#enter_your_message".translate(context),
                        controller: notifier.messageTextController,
                        onChanged: (_) => notifier.handleOnTextChanged(),
                      ),
                      if (isRecording)
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          top: SharedStyles.componentsPadding,
                          end: 10.0,
                          child: Text(
                            watcher.recordDuration.stringFormat,
                            style: TextStyles.subtitle2.copyWith(
                              height: 1.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 5.0),
                FloatingActionButton(
                  heroTag: textMode ? "send" : "microphone",
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  focusElevation: 0.0,
                  highlightElevation: 0.0,
                  hoverElevation: 0.0,
                  child: SvgPicture.asset(
                    textMode
                        ? "assets/icons/send.svg"
                        : "assets/icons/microphone.svg",
                    color: isRecording ? Palette.burntSienna : null,
                    height: 22.0,
                    width: 22.0,
                  ),
                  onPressed: () => textMode
                      ? notifier.sendTextMessage(peerId)
                      : notifier.onVoiceRecordButtonClicked(
                          context,
                          peerId: peerId,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
