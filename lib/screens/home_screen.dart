import 'package:flutter/material.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';
import 'homepage/landing_screen.dart';
import 'homepage/notification_screen.dart';
import 'homepage/people_screen.dart';
import 'homepage/profile_screen.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/ic_home.png"),
                size: 20,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/ic_calendar.png"),
                size: 20,
              ),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/ic_notification.png"),
                size: 20,
              ),
              label: 'Updates',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/ic_wallet.png"),
                size: 20,
              ),
              label: 'Wallet',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.amberAccent,
          unselectedItemColor: Colors.grey,
          iconSize: 20,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
