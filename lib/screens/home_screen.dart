import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/screens/home_screen.dart';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> getToken() async {
    SharedPreferencesHelper.init();
    String? token = await SharedPreferencesHelper.getString('token');
    return token ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10.0),
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
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/ic_calendar.png"),
                    size: 20,
                  ),
                  label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/ic_friends.png"),
                    size: 20,
                  ),
                  label: 'Friends'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/ic_wallet.png"),
                    size: 20,
                  ),
                  label: 'Wallet')
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.amberAccent,
            unselectedItemColor: Colors.grey,
            iconSize: 26,
            backgroundColor: Colors.white,
            currentIndex: 0,
          ),
        ));
  }
}

/*
*
*    child: FutureBuilder<String>(
            future: getToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Text(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text('No token available');
              }
            },
          ),
* */
