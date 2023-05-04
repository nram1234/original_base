import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/widgets/chat/screens/private_chat_room_screen.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/core/services/local_storage/logged_in_user_helper.dart';
import 'package:original_base/src/core/services/chat/new_chat_room_client.dart';
import 'package:original_base/src/ui/widgets/popups/snack_bar_alert.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/ui/widgets/loading/loading_popup.dart';
import 'package:original_base/src/core/models/user.dart';
//-------------------------------------------------------

class ChatRoomRedirectHandler {
  final _client = NewChatRoomClient();

  Future<void> goToDealerChatRoom({
    required User peer,
    required BuildContext context,
  }) async {
    User loggedInUser = LoggedInUserHelper().storedUser!;
    if (peer.id == loggedInUser.id) {
      return showSnackBarAlert("#self_chat_try", context);
    }

    try {
      showLoadingPopup("#redirecting_to_chat_room", context);
      late String chatRoomId;
      String? existingChatRoomId = await _client.getExistingRoomId(peer.id);
      if (existingChatRoomId != null) {
        chatRoomId = existingChatRoomId;
      } else {
        String newChatRoomId = await _client.startNewChatRoom(peer);
        chatRoomId = newChatRoomId;
      }
      Sailor.back();
      Sailor.to(
        PrivateChatRoomScreen(
          roomId: chatRoomId,
          peerId: peer.id.toString(),
          peerName: peer.name,
        ),
      );
    } catch (error, stackTrace) {
      Sailor.back();
      String errorId = resolveClientError(error, stackTrace);
      showSnackBarAlert(errorId, context);
    }
  }
}
