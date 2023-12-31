import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/screens/allow_notifications_screen.dart';
import 'package:test_flutter/presentation/screens/create_password_screen.dart';
import 'package:test_flutter/presentation/screens/create_username.dart';
import 'package:test_flutter/presentation/screens/sign_in_screen.dart';
import 'package:test_flutter/presentation/screens/sign_up_screen.dart';
import 'package:test_flutter/presentation/screens/verify_otp_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes(BuildContext context) {
    return {
      SignInScreen.routeName: (BuildContext context) => const SignInScreen(),
      SignUpScreen.routeName: (BuildContext context) {
        final email = ModalRoute.of(context)?.settings.arguments as String?;
        return SignUpScreen(
          email: email ?? "",
        );
      },
      VerifyOTPScreen.routeName: (BuildContext context) {
        final email = ModalRoute.of(context)?.settings.arguments as String?;
        return VerifyOTPScreen(
          mEmail: email ?? "",
        );
      },
      CreatePasswordScreen.routeName: (BuildContext context) =>
          const CreatePasswordScreen(),
      CreateUsernameScreen.routeName: (BuildContext context) =>
          const CreateUsernameScreen(),
      AllowNotificationsScreen.routeName: (BuildContext context) =>
          const AllowNotificationsScreen(),
    };
  }
}
