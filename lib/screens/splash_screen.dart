import 'package:flutter/material.dart';
import 'package:test_flutter/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/screens/splash_screen.dart';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text("Hello, Sharon"))),
    );
  }
}
