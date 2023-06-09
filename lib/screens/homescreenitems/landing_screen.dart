import 'package:flutter/material.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late String tokenValue;

  Future<String?> getTokenValue() async {
    await SharedPreferencesHelper.init();
    var token = await SharedPreferencesHelper.getString('token');
    setState(() {
      tokenValue = token!;
    });

    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SafeArea(child: Text(getTokenValue() == null ? "null" : tokenValue)),
    );
  }
}
