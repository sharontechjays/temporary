

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    var isValidToken=getValue()!=null && getValue()!="";
    Future.delayed(const Duration(seconds: 3), () {


      Navigator.pushReplacementNamed(
        context,
        (!isValidToken)
            ? LoginScreen.routeName
            : HomeScreen.routeName,
      );
    });

    print(getValue());
    super.initState();
  }

  Future<String?> getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('token')) {
      String? token = prefs.getString('token');
      return token;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text("Hello, Sharon"))),
    );
  }
}
