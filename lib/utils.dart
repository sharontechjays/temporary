import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';

class Utils {
  String getSecretKey() {
    return "gAAAAABju5HOav4K3tq1rCVSBKb20t7-Ha5P9o9OOVlnfnL9LuxtxNYEsVeD58YwXD5KXVBF3l_jBjagg86SceIgA4N6vhh57IpAvMmmEHRY0dnzsHoZYLWtVTkjq8t7GUbkkHXYol88Gj7Z1RpjXfnFkesL3vuWKA==";
  }

  Future<String?> getToken(BuildContext context) async {
    await SharedPreferencesHelper.init();
    var token = await SharedPreferencesHelper.getString('token');
    return token;
  }
}
