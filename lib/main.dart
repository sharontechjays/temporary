import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/splash_screen.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shield Up',
      routes: AppRoutes.appRoutes(context),
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      home: const SplashScreen(),
    );
  }
}
