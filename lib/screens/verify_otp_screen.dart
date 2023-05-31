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
  var localStorage = SharedPreferencesHelper();
  final _verifyTextEditingController = TextEditingController();

  void _postValues(String value) {
    if (value.trim().length == 4) {
      String mobileNumber = widget.mobileNumber;
      String countryCode = widget.countryCode;
      var json = {
        "mobile_number": mobileNumber,
        "country_code": countryCode,
        "otp": _verifyTextEditingController.text.trim()
      };

      LoginServices().verifyOtp(context, json).then((value) async {
        if (value.result!) {
          SharedPreferencesHelper.init();
          await SharedPreferencesHelper.setString('token', value.data!.token!);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Fluttertoast.showToast(msg: 'Toast message');
          });
        } else {
          Fluttertoast.showToast(msg: value.msg!);
        }
      }).catchError((onError) {
        print(onError.toString());
        Fluttertoast.showToast(msg: "error");
      });
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
                      label: Text("Please enter the OTP")),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

/*
* {Secret-Key=gAAAAABju5HOav4K3tq1rCVSBKb20t7-Ha5P9o9OOVlnfnL9LuxtxNYEsVeD58YwXD5KXVBF3l_jBjagg86SceIgA4N6vhh57IpAvMmmEHRY0dnzsHoZYLWtVTkjq8t7GUbkkHXYol88Gj7Z1RpjXfnFkesL3vuWKA==, device=439890614c1f9d55, platform=android, Content-Type=application/json}
09:26:17.127  D  https://stg-api.shieldup.ai/api/portal/verify_otp/
09:26:17.127  D  POST
09:26:17.127  D  retrofit2.RequestBuilder$ContentTypeOverridingRequestBody@eced000
09:26:17.129  D  {"country_code":"+91","mobile_number":"9847402299","otp":"9999"}
09:26:17.424  D  {"result":true,"msg":"OTP Verified Successfully","data":{"user_id":187,"token":"a827608c1ebbf2cb9dba91c9a3da9d060c7de65c","mobile_number":"9847402299","is_pin_available":true,"first_name":"Hgh","last_name":"Nnnd"}}
* */
