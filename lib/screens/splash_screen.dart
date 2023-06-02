import 'package:flutter/material.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';
import 'package:test_flutter/screens/home_screen.dart';
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
    SharedPreferencesHelper.init();
    var _token = SharedPreferencesHelper.getString('token');

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        (_token == null) ? LoginScreen.routeName : HomeScreen.routeName,
      );
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
