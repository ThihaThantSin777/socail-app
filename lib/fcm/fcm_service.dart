import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  static final FCMService _singleton = FCMService._internal();

  factory FCMService() => _singleton;

  FCMService._internal();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high importance channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('ic_launcher');

  void listenForMessage() async {
    await requestNotificationPermissionForIOS();
    await turnOnIOSForegroundNotification();

    // await initFlutterLocalNotification();
    // await registerChannel();

    messaging.getToken().then((fcmToken) {
      debugPrint('FCM Token For Device ===========> $fcmToken');
    });

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      debugPrint('Notification Sent From Server while in foreground');
      RemoteNotification? notification = remoteMessage.notification;
      AndroidNotification? android = remoteMessage.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            )),
          payload: remoteMessage.data['post_id'].toString()
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      debugPrint(
          'User pressed the Notification ${remoteMessage.data['post_id']}');
    });
    messaging.getInitialMessage().then((remoteMessage) {
      debugPrint('Message Launched ${remoteMessage?.data['post_id']}');
    });
  }

  Future requestNotificationPermissionForIOS() {
    return messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future turnOnIOSForegroundNotification() {
    return FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future initFlutterLocalNotification() {
    final InitializationSettings initializationSettings =
         InitializationSettings(
          android: initializationSettingsAndroid,
      iOS: null,
      macOS: null,
    );
    return flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (payload){
      debugPrint('Local Notification Clicked =========> $payload');
    });
  }

  Future? registerChannel() {
    return flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
