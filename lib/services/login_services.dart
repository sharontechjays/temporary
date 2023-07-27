import 'package:test_flutter/network_service/rest_client.dart';

import '../constants/constants.dart';
import '../models/login_model.dart';
import '../models/user.dart';

class LoginServices {
  Future<LoginModel> loginUser(String email, String password) async {
    var dioClient = RestClient();
    var result = dioClient.loginUser(email, password);
    return result;
  }
}
