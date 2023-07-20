import 'dart:html';

import 'package:dio/dio.dart';
import 'dart:io' as platform_dart;
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_flutter/models/user.dart';
import '../constants/constants.dart';
import 'package:dio/dio.dart' hide Headers;

import '../models/notifications.dart';
import '../models/otp_model.dart';
import '../utils.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient._;

  @POST("register_user/")
  Future<User> createUser(
    @Body() Map<String, dynamic> map,
    @Header("Content-Type") String contentType,
    @Header("device") String device,
    @Header("platform") String platform,
    @Header("Secret-Key") String secretKey,
  );

  @POST("verify_otp/")
  Future<OtpModel> verifyOtp(
    @Body() Map<String, dynamic> map,
    @Header("Content-Type") String contentType,
    @Header("device") String device,
    @Header("platform") String platform,
    @Header("Secret-Key") String secretKey,
  );

  @GET("notifications_list/")
  Future<Notifications> notificationList(
    @Query("limit") int limit,
    @Query("offset") int offset,
    @Header("Content-Type") String contentType,
    @Header("device") String device,
    @Header("platform") String platform,
    @Header("Authorization") String token,
  );

  RestClient._();

  static RestClient create() {
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final fullUrl = options.uri.toString();
          final queryParams = options.queryParameters;
          final headers = options.headers;
          headers['Content-Type']="application/json";
          headers['device']=Utils().getDeviceId();
          headers['platform']=Utils().getPlatformName();
          @Header("Authorization") String token;


          debugPrint('API Request: ${options.method} $fullUrl');
          if (queryParams != null && queryParams.isNotEmpty) {
            debugPrint('Parameters: $queryParams');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
           /* debugPrint(
                'API Response: ${response.statusCode} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
         */ }
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          if (kDebugMode) {
            debugPrint(
                'API Error: ${error.requestOptions.baseUrl}${error.requestOptions.path}');
          }
          return handler.next(error);
        },
      ),
    );
    return RestClient(dio);
  }
}
