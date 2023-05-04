import 'package:firebase_messaging/firebase_messaging.dart';
//----------------------------------------------------------
import 'package:original_base/src/core/services/notifications/local_notifications_service.dart';
import 'package:original_base/src/ui/widgets/chat/screens/private_chat_room_screen.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/core/services/notifications/push_token_client.dart';
//------------------------------------------------------------------------------------

class FirebaseMessagingService {
  final _instance = FirebaseMessaging.instance;

  void registerNotificationsHandlers() {
    _instance.requestPermission();

    FirebaseMessaging.onMessageOpenedApp.listen(_handleFcmChatNotification);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null && message.data.isNotEmpty) {
        LocalNotificationsService().showNotificationFromRemoteMessage(message);
      }
    });

    _instance.onTokenRefresh.listen(PushTokenClient().updateUserPushToken);
  }

  /// Handles initial message that opened the app from a terminated state.
  void handleInitialMessage() {
    _instance.getInitialMessage().then((RemoteMessage? message) {
      _handleFcmChatNotification(message);
    });
  }

  Future<String?> getDefaultPushToken() async {
    String? devicePushToken = await _instance.getToken();
    return devicePushToken;
  }

  void invalidateDevicePushToken() {
    _instance.deleteToken();
  }

  void _handleFcmChatNotification(RemoteMessage? message) {
    if (message != null && message.data.isNotEmpty) {
      Sailor.to(
        PrivateChatRoomScreen(
          roomId: message.data["room_id"],
          peerId: message.data["peer_id"],
          peerName: message.data["peer_name"],
        ),
      );
    }
  }
}
