import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';
import 'package:test_flutter/screens/home_screen.dart';

import '../services/login_services.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String countryCode;
  static const String routeName = '/screens/verify_otp_screen.dart';

  const VerifyOtpScreen({
    Key? key,
    required this.mobileNumber,
    required this.countryCode,
  }) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _verifyTextEditingController = TextEditingController();

  Future<void> _postValues(String value) async {
    if (value.trim().length == 4) {
      String mobileNumber = widget.mobileNumber;
      String countryCode = widget.countryCode;
      var json = {
        "mobile_number": mobileNumber,
        "country_code": countryCode,
        "otp": _verifyTextEditingController.text.trim()
      };

      try {
        var value = await LoginServices().verifyOtp(context, json);
        if (value.result!) {
          print(value.data.toString());
          SharedPreferencesHelper.init();
          await SharedPreferencesHelper.setString(
              'token', "Token ${value.data!.token!}");

          await Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          Fluttertoast.showToast(msg: value.msg!);
        }
      } catch (error) {
        print(error.toString());
        Fluttertoast.showToast(msg: "Error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: TextField(
                    controller: _verifyTextEditingController,
                    onChanged: (value) => _postValues(value),
                    maxLength: 4,
                    decoration: const InputDecoration(
                      labelText: "Please enter the OTP",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
