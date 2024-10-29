import 'package:app_notification/page/home_screen.dart';
import 'package:app_notification/page/splash_screen.dart';
import 'package:app_notification/page/notification_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'App Notification',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const HomePage(),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        NotificationScreen.route: (context) => const NotificationScreen(),
        TestPage2.route: (context) => const TestPage2(),
      },
    );
  }
}
