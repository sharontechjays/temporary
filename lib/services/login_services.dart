import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/network_service/rest_client.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/utils.dart';
import 'package:test_flutter/exceptions/auth_exception.dart';

import '../models/otp_model.dart';

class LoginServices {
  var client = RestClient(Dio());
  var util = Utils();

/*  Future<User> postLoginCredentials(
      BuildContext context, Map<String, Object> param) async {
    print(param.toString());
    var val = await client
        .createUser(param, "application/json", "device", "android",
            Utils().getSecretKey())
        .catchError((onError) {
      print(param.toString());
      print(onError.response.toString());
      throw AuthenticationException(
          message: onError.response.data['msg'].toString());
    });
    return val;
  }*/

  Future<User> postLoginCredentials(BuildContext context,
      Map<String, Object> param) async {
    try {
      var val = await client.createUser(
        param,
        "application/json",
        "device",
        "android",
        Utils().getSecretKey(),
      );
      return val;
    } catch (error) {
      throw Future.error(error);
    }
  }
  Future<OtpModel> verifyOtp(BuildContext context,
      Map<String, Object> param) async {
    try {
      var val = await client.verifyOtp(
        param,
        "application/json",
        "device",
        "android",
        Utils().getSecretKey(),
      );
      return val;
    } catch (error) {
      throw Future.error(error);
    }
  }
}
