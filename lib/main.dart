import 'dart:developer';

import 'package:app_notification/service/navigation_service.dart';
import 'package:app_notification/service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initialize();
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  runApp(const MyApp());
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  log(message.notification?.body ?? ''.toString());
  // try {
  //   BuildContext? context = NavigationService.navigatorKey.currentContext;
  //   Navigator.of(
  //     context!,
  //   ).push(MaterialPageRoute(builder: (context) => const TestPage1()));
  // } catch (e) {
  //   log(e.toString());
  // }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    // Get initial message (app was killed, and a notification opened the app)
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        // App was opened via a notification
        _navigateToSpecificPage(message.data);
      }
    });

    // Handle notifications when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Foreground notification: ${message.notification?.title}');
        // Show a notification or update the UI
      }
    });

    // Handle notifications when the app is in the background (but not killed)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data != null) {
        _navigateToSpecificPage(message.data);
      }
    });
  }
  void _navigateToSpecificPage(Map<String, dynamic> data) {
    if (data['screen'] == 'details') {
      Navigator.pushNamed(context, '/details');
    } else if (data['screen'] == 'home') {
      Navigator.pushNamed(context, '/home');
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                NotificationService().getToken();
              },
              child: const Text('Get Token'))
        ],
      ),
    );
  }
}
