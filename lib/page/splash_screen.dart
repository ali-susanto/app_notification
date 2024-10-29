import 'package:app_notification/page/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.route, (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'SPLASH SCREEN',
            style: TextStyle(fontSize: 28),
          ),
          Icon(
            Icons.flutter_dash,
            size: 64,
          )
        ],
      ),
    );
  }
}
