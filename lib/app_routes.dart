import 'package:flutter/material.dart';
import 'package:test_flutter/screens/splash_screen.dart';
import 'package:test_flutter/screens/login_screen.dart';
import 'package:test_flutter/screens/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes(BuildContext context) {
    return {
      SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
      LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
      HomeScreen.routeName: (BuildContext context) => const HomeScreen()
    };
  }
}
