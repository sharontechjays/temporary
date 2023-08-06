import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/screens/homepage.dart';
import 'package:test_flutter/presentation/screens/onboarding/onboarding.dart';
import 'presentation/screens/sign_in_screen.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Base setup',
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}
