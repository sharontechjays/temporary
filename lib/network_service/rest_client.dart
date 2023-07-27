import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:test_flutter/constants/constants.dart';
import 'package:test_flutter/models/login_model.dart';
import 'package:test_flutter/utils.dart';

class RestClient {
  static final RestClient _instance = RestClient._internal();
  final Dio _dio;

  factory RestClient() {
    return _instance;
  }

  RestClient._internal() : _dio = Dio() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.baseUrl = BASE_URL;
          options.connectTimeout = const Duration(seconds: 6);
          options.receiveTimeout = const Duration(seconds: 6);
          options.sendTimeout = const Duration(seconds: 6);

          final queryParams = options.queryParameters;
          final headers = options.headers;
          final body = options.data;
          headers['Content-Type'] = "application/json";
          headers['device'] = Utils().getDeviceId();
          headers['platform'] = Utils().getPlatformName();

          print('Request URl: ${options.method} ${options.uri}');
          print('Request Body: ${options.data}');
          if (queryParams != null && queryParams.isNotEmpty) {
            print('Parameters: $queryParams');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("StatusCode : ${response.statusCode}");
          if (response.statusCode == 200) {
            //return ApiResponse(data: response.data,result: true,msg: "success",isNextLink: true);
            print("Response body : ${response.data}");
            return handler.next(response);
          } else {
            print("Response body : ${response.data}");
            return handler.next(response);
          }
        },
        onError: (DioException error, handler) {
          print('API Error:${error.message} ');
          return handler.next(error);
        },
      ),
    );
  }

  String _constructUrl(String endpoint) {
    return '$BASE_URL$endpoint';
  }

  // end Points
  String login = 'login';

  //functions here

  Future<LoginModel> loginUser(String email, String password) async {
    final Map<String, dynamic> loginData = {
      'username': email,
      'password': password,
    };
    try {
      final response = await _dio.post(
        _constructUrl(login),
        data: loginData,
      );
      return LoginModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Login failed. Please check your credentials.');
    }
  }
}
