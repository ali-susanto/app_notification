import 'dart:developer';

import 'package:app_notification/page/test_page1.dart';
import 'package:app_notification/service/navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    _fcm.requestPermission();
    await getToken();
    listenMessage();
  }

  Future<void> listenMessage() async {
    try {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);
      FirebaseMessaging.onMessage.listen(
          // (response) {
          //   log('Get a message on foreground');
          //   log('Message Data: ${response.data}');

          //   if (response.notification != null) {
          //     log('Message info : ${response.notification?.body}');
          //   }
          // },
          _handleMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(
          // (event) {
          //   // if(event.notification)
          //   try {
          //     log(event.notification!.body.toString());
          //     BuildContext? context =
          //         NavigationService.navigatorKey.currentContext;
          //     Navigator.push(context!,
          //         MaterialPageRoute(builder: (context) => const TestPage1()));
          //   } catch (e) {
          //     log(e.toString());
          //   }
          // },
          _handleMessage);
      // FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    } catch (e) {
      //
    }
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // if (message.data.isNotEmpty) {
    try {
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      Navigator.push(
          context!, MaterialPageRoute(builder: (context) => const TestPage1()));
    } catch (e) {
      log(e.toString());
    }
    // }
  }

  void _handleMessage(RemoteMessage? message) {
    if (message == null) return;
    NavigationService.navigatorKey.currentState?.pushNamed(TestPage1.route);
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    log('notif token: $token');
    return token;
  }
}
