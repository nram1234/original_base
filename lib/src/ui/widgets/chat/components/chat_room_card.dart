import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/animation/animation_gesture_detector.dart';
import 'package:original_base/src/core/models/chat/chat_room.dart';
import 'package:original_base/src/core/utils/time_ago_util.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ChatRoomCard extends StatelessWidget {
  final String peerId;

  final Color userIconColor;

  final Stream<DocumentSnapshot> userOnlineStream;
  final Stream<QuerySnapshot> unreadMessagesStream;

  final ChatRoom chatRoom;

  final VoidCallback onTapped;

  const ChatRoomCard({
    required this.peerId,
    required this.userIconColor,
    required this.userOnlineStream,
    required this.unreadMessagesStream,
    required this.chatRoom,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    final roomTappedNotifier = ValueNotifier<bool>(false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AnimationGestureDetector(
        valueNotifier: roomTappedNotifier,
        onTouch: onTapped,
        child: ValueListenableBuilder<bool>(
          valueListenable: roomTappedNotifier,
          builder: (_, tapped, __) {
            return Container(
              height: 86.0,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: SharedStyles.componentsPadding,
              ),
              decoration: BoxDecoration(
                color: tapped ? Palette.solitude : Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(
                  SharedStyles.mediumComponentsRadius,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  SharedStyles.smallComponentsRadius,
                                ),
                                child: Material(
                                  shape: CircleBorder(),
                                  color: userIconColor,
                                  child: SizedBox(
                                    height: 58.0,
                                    width: 58.0,
                                    child: Center(
                                      child: Text(
                                        chatRoom.membersNames[peerId]
                                            .toString()[0]
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          height: 1.0,
                                          fontSize: 34.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            StreamBuilder<DocumentSnapshot>(
                              stream: userOnlineStream,
                              builder: (_, AsyncSnapshot snapshot) {
                                bool userIsOnline = false;
                                try {
                                  if (snapshot.hasData) {
                                    userIsOnline = snapshot.data!.get("online");
                                  }
                                } catch (_) {}

                                return Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  child: Container(
                                    height: 10.0,
                                    width: 10.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: userIsOnline
                                          ? Palette.burntSienna
                                          : Palette.shuttleGray,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(width: 15.0),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  chatRoom.membersNames[peerId],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.subtitle2.copyWith(
                                    color: Palette.bigStone,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.0),
                              Flexible(
                                child: Text(
                                  chatRoom.lastMessage
                                      .toStringRepresentation(context),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.caption,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: SharedStyles.componentsPadding),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: unreadMessagesStream,
                        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            int unreadMessages = snapshot.data!.docs.length;
                            if (unreadMessages > 0) {
                              return Container(
                                height: 33.0,
                                width: 33.0,
                                margin: const EdgeInsets.only(bottom: 8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Palette.burntSienna,
                                ),
                                child: Center(
                                  child: Text(
                                    unreadMessages > 99
                                        ? "99+"
                                        : "$unreadMessages",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyles.caption.copyWith(
                                      height: 1.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }

                          // default widget when [unreadMessagesStream] is loading
                          // or there are no unread messages.
                          return SizedBox();
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            TimeAgoUtil().formatTime(
                              chatRoom.lastMessage.sendDate,
                              context.langCode,
                            ),
                            style: TextStyles.caption.copyWith(height: 1.0),
                          ),
                          SizedBox(width: 5.0),
                          SvgPicture.asset(
                            "assets/icons/time.svg",
                            height: 14.0,
                            width: 14.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
