import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_flutter/models/user.dart';
import '../constants/constants.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("register_user/")
  Future<User> createUser(
    @Body() Map<String, dynamic> map,
    @Header("Content-Type") String contentType,
    @Header("device") String device,
    @Header("platform") String platform,
    @Header("Secret-Key") String secretKey,
  );
}
