import 'dart:math';
//-----------------
import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/widgets/chat/components/firestore_pagination_widget.dart';
import 'package:original_base/src/ui/widgets/chat/screens/private_chat_room_screen.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/widgets/loading/circular_loading_indicator.dart';
import 'package:original_base/src/ui/widgets/chat/components/chat_room_card.dart';
import 'package:original_base/src/ui/widgets/layout/scaffold_curved_body.dart';
import 'package:original_base/src/core/services/chat/chat_rooms_client.dart';
import 'package:original_base/src/ui/widgets/layout/screen_header.dart';
import 'package:original_base/src/core/models/chat/chat_room.dart';
import 'package:original_base/src/ui/widgets/failure_widget.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ChatRoomsScreen extends StatelessWidget {
  final _client = ChatRoomsClient();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ScreenHeader(
          title: "#chat".translate(context),
        ),
        body: ScaffoldCurvedBody(
          horizontalPadding: SharedStyles.componentsPadding,
          child: FirestorePaginationWidget(
            isLive: true,
            itemsPerPage: ChatRoomsClient.roomsPerPage,
            query: _client.chatRoomsQuery,
            initialLoader: CircularLoadingIndicator(),
            bottomLoader: CircularLoadingIndicator(),
            emptyDisplay: FailureWidget(
              bottomPadding: 25.0 + SharedStyles.screenHeaderHeight,
              title: "#no_chat".translate(context),
              failureType: FailureType.emptyResult,
            ),
            itemBuilder: (_, __, chatRoomDocument) {
              var chatRoom = ChatRoom.fromDocument(chatRoomDocument);
              Map membersIds = chatRoom.membersIds;
              String peerId = _client.getPeerId(membersIds);
              return ChatRoomCard(
                userIconColor: Palette.darkColors[Random().nextInt(
                  Palette.darkColors.length,
                )],
                onTapped: () {
                  Sailor.to(
                    PrivateChatRoomScreen(
                      roomId: chatRoomDocument.id,
                      peerId: peerId,
                      peerName: chatRoom.membersNames[peerId],
                    ),
                  );
                },
                peerId: peerId,
                chatRoom: chatRoom,
                userOnlineStream: _client.getPeerUserOnlineStream(membersIds),
                unreadMessagesStream:
                    _client.getUnreadMessagesStream(chatRoom.uid),
              );
            },
          ),
        ),
      ),
    );
  }
}
