
import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/screens/sign_in_screen.dart';
import 'package:test_flutter/presentation/screens/sign_up_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes(BuildContext context) {
    return {
      SignInScreen.routeName: (BuildContext context) =>  const SignInScreen(),
      SignUpScreen.routeName: (BuildContext context) =>  const SignUpScreen(),
   /*   VerifyOtpScreen.routeName: (BuildContext context) {
        final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        final mobileNumber = arguments?['mobileNumber'] as String?;
        final countryCode = arguments?['countryCode'] as String?;

        return VerifyOtpScreen(
          mobileNumber: mobileNumber ?? '',
          countryCode: countryCode ?? '',
        );
      },*/
    };
  }
}
