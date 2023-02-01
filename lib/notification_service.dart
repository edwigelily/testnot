// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();


  // Initialisation du service de notification
  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            print('clique sur la notification ----------------> ${NotificationResponseType.selectedNotification}');

            break;
          case NotificationResponseType.selectedNotificationAction:
            print('l\'action --------------------> ${notificationResponse.actionId}');

            break;
        }
      },
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      print('-------------------------------------------------->');
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "test-d9ab5",
          "test-d9ab5channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['id'],
      );
      print(message.data['id']);
    } on Exception catch (e) {
      print(e);
    }
  }


  // Recuperation du token de notification
  static Future<String> getDeviceTokenToSendNotification() async {
    String deviceTokenToSendPushNotification = "";
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
    return deviceTokenToSendPushNotification;
  }

}
