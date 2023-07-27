/*
import 'package:flutter/material.dart';
import 'package:test_flutter/screens/splash_screen.dart';
import 'package:test_flutter/screens/login_screen.dart';
import 'package:test_flutter/screens/home_screen.dart';
import 'package:test_flutter/screens/verify_otp_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes(BuildContext context) {
    return {
      SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
      LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
      HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
      VerifyOtpScreen.routeName: (BuildContext context) {
        final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        final mobileNumber = arguments?['mobileNumber'] as String?;
        final countryCode = arguments?['countryCode'] as String?;

        return VerifyOtpScreen(
          mobileNumber: mobileNumber ?? '',
          countryCode: countryCode ?? '',
        );
      },
    };
  }
}
*/
