import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/screens/home_screen.dart';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [

          ],
        ),
        ),
      ),
      );
  }
}
