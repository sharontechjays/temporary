import 'package:test_flutter/models/api_response.dart';
import 'package:test_flutter/network_service/rest_client.dart';
import '../models/login_model.dart';

class LoginServices {
  String login = 'auth/login';

  Future<ApiResponse<LoginModel>> loginUser(
      String email, String password) async {
    var dioClient = RestClient();
    return dioClient.postRequest<LoginModel>(
      endpoint: login,
      data: {
        'username': email,
        'password': password,
      },
      fromJson: (json) => LoginModel.fromJson(json),
    );
  }
}
