import 'package:flutter/cupertino.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';

class Utils {
  String getSecretKey() {
    return "gAAAAABju5HOav4K3tq1rCVSBKb20t7-Ha5P9o9OOVlnfnL9LuxtxNYEsVeD58YwXD5KXVBF3l_jBjagg86SceIgA4N6vhh57IpAvMmmEHRY0dnzsHoZYLWtVTkjq8t7GUbkkHXYol88Gj7Z1RpjXfnFkesL3vuWKA==";
  }

  Future<String?> getToken() async {
    SharedPreferencesHelper.init();
    return await SharedPreferencesHelper.getString('token');
  }
}
