import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter/models/notifications.dart';
import 'package:test_flutter/network_service/rest_client.dart';
import 'package:test_flutter/utils.dart';

class NotificationServices {
  var client = RestClient(Dio());
  var util = Utils();

  Future<Notifications> getNotifications(
      BuildContext context, Map<String, Object> param) async {
    try {
      var val = await client.notificationList(
        param,
        "application/json",
        "device",
        "android",
        await Utils().getToken() as String,
      );
      return val;
    } catch (error) {
      throw Future.error(error);
    }
  }
}
