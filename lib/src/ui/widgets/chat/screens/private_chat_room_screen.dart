import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/ui/widgets/chat/components/firestore_pagination_widget.dart';
import 'package:original_base/src/core/view_models/chat/private_chat_room_notifier.dart';
import 'package:original_base/src/ui/widgets/chat/components/chat_room_bottom_bar.dart';
import 'package:original_base/src/ui/widgets/chat/components/chat_message_bubble.dart';
import 'package:original_base/src/core/services/shared/user_online_status_client.dart';
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/widgets/loading/circular_loading_indicator.dart';
import 'package:original_base/src/ui/widgets/chat/components/peer_contact_card.dart';
import 'package:original_base/src/core/services/chat/private_chat_room_client.dart';
import 'package:original_base/src/core/view_models/chat/peer_info_provider.dart';
import 'package:original_base/src/ui/widgets/layout/scaffold_curved_body.dart';
import 'package:original_base/src/ui/widgets/layout/screen_header.dart';
import 'package:original_base/src/core/models/chat/chat_message.dart';
import 'package:original_base/src/core/models/user.dart';
import 'package:original_base/src/config/app_theme.dart';
//-------------------------------------------------------

class PrivateChatRoomScreen extends StatefulWidget {
  final String roomId;
  final String peerId;
  final String peerName;

  const PrivateChatRoomScreen({
    required this.roomId,
    required this.peerId,
    required this.peerName,
  });

  @override
  _PrivateChatRoomScreenState createState() => _PrivateChatRoomScreenState();
}

class _PrivateChatRoomScreenState extends State<PrivateChatRoomScreen> {
  late final PrivateChatRoomClient _client;
  late final PrivateChatRoomNotifier _notifier;

  @override
  void initState() {
    super.initState();
    UserOnlineStatusClient.openedChatRoomId = widget.roomId;
    _client = PrivateChatRoomClient(widget.roomId);
    _notifier = context.read(privateChatRoomProvider(_client));
    _client.changeMemberOnRoomStatus(true);
  }

  @override
  void dispose() {
    UserOnlineStatusClient.openedChatRoomId = null;
    _client.changeMemberOnRoomStatus(false);
    super.dispose();
  }

  bool checkIfSelfMessage(ChatMessage message, String peerId) {
    return message.senderId != int.parse(peerId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ScreenHeader(title: widget.peerName),
        body: Column(
          children: [
            Expanded(
              child: ScaffoldCurvedBody(
                horizontalPadding: SharedStyles.componentsPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 15.0),
                    Consumer(
                      builder: (_, watch, __) {
                        return watch(peerInfoProvider(widget.peerId)).when(
                          data: (User? peerUser) {
                            return peerUser != null
                                ? PeerContactCard(peerUser)
                                : Container();
                          },
                          loading: () => SizedBox(
                            height: 98.0,
                            width: double.infinity,
                            child: CircularLoadingIndicator(),
                          ),
                          error: (_, __) => Container(),
                        );
                      },
                    ),
                    SizedBox(height: 15.0),
                    Expanded(
                      child: FirestorePaginationWidget(
                        isLive: true,
                        reverse: true,
                        itemsPerPage: PrivateChatRoomClient.messagesPerPage,
                        query: _client.chatMessagesQuery,
                        scrollController: _notifier.scrollController,
                        initialLoader: CircularLoadingIndicator(),
                        bottomLoader: CircularLoadingIndicator(),
                        itemBuilder: (_, __, messageDocument) {
                          _client.setMessageToRead(messageDocument);
                          ChatMessage message = ChatMessage.fromMap(
                            messageDocument.data() as Map,
                          );
                          return ChatMessageBubble(
                            isRTL: context.isRTL,
                            selfMessage: checkIfSelfMessage(
                              message,
                              widget.peerId,
                            ),
                            chatMessage: message,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SharedStyles.componentsPadding),
            ChatRoomBottomBar(
              peerId: widget.peerId,
              client: _client,
              notifier: _notifier,
            ),
          ],
        ),
      ),
    );
  }
}
