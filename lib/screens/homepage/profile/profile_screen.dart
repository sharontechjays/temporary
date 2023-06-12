import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';
import 'package:test_flutter/screens/login_screen.dart';

import 'widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _items = ["Data Permission", "Privacy Policy", "Logout", "FAQs"];

  void logout(BuildContext context) async {
    await SharedPreferencesHelper.init();
    await SharedPreferencesHelper.remove('token');
    await Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('MY Profile'),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.lab_flask),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ProfileItem(
                      title: _items[index],
                      onPressed: () {
                        if (_items[index] == "Logout") {
                          logout(context);
                        }
                      },
                    );
                  },
                  itemCount: _items.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
