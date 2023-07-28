import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:test_flutter/constants/constants.dart';
import 'package:test_flutter/models/api_response.dart';
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
      InterceptorsWrapper(onRequest: (options, handler) async {
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
      }, onResponse: (response, handler) {
        print("StatusCode : ${response.statusCode}");
        if (response.statusCode == 200) {
          print("Response body : ${response.data}");
          return handler.resolve(response);
        } else {
          print("Response status code: ${response.statusCode}");
          print("Response body : ${response.data}");
          final errorResponse = Response(
            statusCode: response.statusCode,
            data: response.data,
            requestOptions: response.requestOptions,
            headers: response.headers,
            isRedirect: response.isRedirect,
            redirects: response.redirects,
            statusMessage: response.statusMessage,
          );
          return handler.reject(DioException(
            requestOptions: RequestOptions(),
            response: errorResponse,
            error: "Request failed with status code ${response.statusCode}",
          ));
        }
      }),
    );
  }

  String _constructUrl(String endpoint) {
    return '$BASE_URL$endpoint';
  }

  // end Points
  String login = 'login';

  //functions here
  Future<ApiResponse<LoginModel>> loginUser(
      String email, String password) async {
    final Map<String, dynamic> loginData = {
      'username': email,
      'password': password,
    };
    try {
      final response = await _dio.post(
        _constructUrl(login),
        data: loginData,
      );
      return handleResponse<LoginModel>(response, LoginModel.fromJson);
    } catch (error) {
      return handleErrorResponse<LoginModel>(error);
    }
  }

  ApiResponse<T> handleResponse<T>(
    Response<dynamic> response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (response.statusCode == 200) {
      return ApiResponse<T>(
        data: fromJson(response.data),
        result: true,
        msg: "success",
        isNextLink: true,
      );
    } else {
      return ApiResponse<T>(
        result: false,
        data: response.data as T,
        msg: "Request failed with status code ${response.statusCode}",
        statusCode: response.statusCode,
      );
    }
  }

  ApiResponse<T> handleErrorResponse<T>(dynamic error) {
    if (error is DioException && error.response != null) {
      print(error.response);
      return ApiResponse<T>(
        result: false,
        data: null,
        msg: "${error.response!.statusCode}/${error.response!.data['message']}",
        statusCode: error.response!.statusCode!,
        responseData: error.response!.data,
      );
    } else {
      return ApiResponse<T>(
        result: false,
        msg: "Error occurred",
        data: null,
      );
    }
  }
}
