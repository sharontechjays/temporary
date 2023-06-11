import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/models/notifications.dart';
import 'package:test_flutter/screens/login_screen.dart';
import 'package:test_flutter/utils.dart';

import '../network_service/rest_client.dart';

class NotificationServices {
  final RestClient client;
  final Utils util;

  NotificationServices(this.client, this.util);

  Future<Notifications> getNotifications(
      BuildContext context, int offset, int limit) async {
    try {
      var token = await util.getToken(context);
      var val = await client.notificationList(
        offset,
        limit,
        "application/json",
        "device",
        "android",
        token!,
      );
      debugPrint(val.toString());
      return val;
    } catch (error) {
      debugPrint(error.toString());
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          Fluttertoast.showToast(msg: error.response!.statusMessage!);
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          return Future.error(error);
        }
      }
      Fluttertoast.showToast(msg: error.toString());
      throw Future.error(error);
    }
  }
}
