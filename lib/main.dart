import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/pages/sign_in_screen.dart';
import 'app_theme.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Base setup',
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      home: const SignInScreen(),
    );
  }
}
