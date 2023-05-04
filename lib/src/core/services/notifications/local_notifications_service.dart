import 'dart:convert';
//--------------------
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//----------------------------------------------------------------------------
import 'package:original_base/src/ui/widgets/chat/screens/private_chat_room_screen.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
//-------------------------------------------------------------------------------------

class LocalNotificationsService {
  final _instance = FlutterLocalNotificationsPlugin();

  void init() {
    _instance.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings("mini_icon"),
        iOS: IOSInitializationSettings(),
      ),
      onSelectNotification: (String? payload) {
        if (payload != null) {
          Map payloadJson = json.decode(payload);
          Sailor.to(
            PrivateChatRoomScreen(
              roomId: payloadJson["room_id"],
              peerId: payloadJson["peer_id"],
              peerName: payloadJson["peer_name"],
            ),
          );
        }
      },
    );
  }

  void showNotificationFromRemoteMessage(RemoteMessage message) async {
    await _instance.show(
      0,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails("com.original.fcm", "Original FCM"),
        iOS: IOSNotificationDetails(
          presentSound: true,
          presentAlert: true,
        ),
      ),
      payload: json.encode(message.data),
    );
  }
}
