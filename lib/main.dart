import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/app_routes.dart';
import 'package:test_flutter/app_theme.dart';
import 'package:test_flutter/presentation/screens/onboarding/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Base setup',
        debugShowCheckedModeBanner: false,
        home: const OnBoardingScreen(),
        routes: AppRoutes.appRoutes(context),
        theme: AppTheme.themeData(context));
  }
}
