import 'package:app_notification/page/test_page1.dart';
import 'package:app_notification/page/test_page2.dart';
import 'package:app_notification/service/navigation_service.dart';
import 'package:app_notification/service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // NotificationService().initialize();
  NotificationService().initOneSignal();
  // FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  // @override
  // void initState() {
  //   super.initState();
  //   // Get initial message (app was killed, and a notification opened the app)
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage? message) {
  //     if (message != null) {
  //       // App was opened via a notification
  //       _navigateToSpecificPage(message.data);
  //     }
  //   });

  //   // Handle notifications when the app is in the foreground
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     if (message.notification != null) {
  //       print('Foreground notification: ${message.notification?.title}');
  //       // Show a notification or update the UI
  //     }
  //   });

  //   // Handle notifications when the app is in the background (but not killed)
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     _navigateToSpecificPage(message.data);
  //   });
  // }

  // void _navigateToSpecificPage(Map<String, dynamic> data) {
  //   if (data['screen'] == 'details') {
  //     Navigator.pushNamed(context, '/details');
  //   } else if (data['screen'] == 'home') {
  //     Navigator.pushNamed(context, '/home');
  //   }
  // }

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
      routes: {
        TestPage1.route: (context) => const TestPage1(),
        TestPage2.route: (context) => const TestPage2(),
      },
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
