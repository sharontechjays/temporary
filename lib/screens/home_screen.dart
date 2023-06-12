import 'package:flutter/material.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';
import 'package:test_flutter/screens/homepage/widgets/bottom_navigation_widget.dart';
import 'homepage/landing_screen.dart';
import 'homepage/notification/notification_screen.dart';
import 'homepage/people_screen.dart';
import 'homepage/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/screens/home_screen.dart';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const LandingScreen(),
    const PeopleScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  Future<String> getToken() async {
    SharedPreferencesHelper.init();
    String? token = await SharedPreferencesHelper.getString('token');
    return token ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int index, _) {
      return _widgetOptions[index];
    }),
    ),
    bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
