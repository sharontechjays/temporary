import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter/network_service/rest_client.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/utils.dart';

import '../models/otp_model.dart';

class ProfileServices {
  var client = RestClient(Dio());
  var util = Utils();

  Future<User> postLoginCredentials(
      BuildContext context, Map<String, Object> param) async {
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
      debugPrint('Error occurred during login: $error');
      throw Future.error(error);
    }
  }
}
