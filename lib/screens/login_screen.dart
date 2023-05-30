import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/services/login_services.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/screens/login_screen.dart';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileNumberController = TextEditingController();
  late String phoneNumber;

  void _login() {
    if (phoneNumber.length == 10) {
      var json = {
        "mobile_number": _mobileNumberController.text.trim(),
        "country_code": "+91"
      };

      LoginServices().postLoginCredentials(context, json).then((value) {
        if (value.result!) {
          Fluttertoast.showToast(msg: value.msg!);
        } else {
          Fluttertoast.showToast(msg: value.msg!);
        }
      }).catchError((onError) {
        print(onError.toString());
        Fluttertoast.showToast(msg: "error");
      });
    } else {
      Fluttertoast.showToast(
        msg: 'The phone number should be 10 digits',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: ' Mobile Number',
                  ),
                  controller: _mobileNumberController,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
