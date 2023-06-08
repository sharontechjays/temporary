import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/models/notifications.dart';
import 'package:test_flutter/network_service/rest_client.dart';
import 'package:test_flutter/screens/home_screen.dart';
import 'package:test_flutter/screens/login_screen.dart';
import 'package:test_flutter/utils.dart';

class NotificationServices {
  var client = RestClient(Dio());
  var util = Utils();

  Future<Notifications> getNotifications(BuildContext context,
      Map<String, Object> param) async {
    try {
      var util = Utils();
      var token = await util.getToken(context);
      var val = await client.notificationList(
        param,
        "application/json",
        "device",
        "android",
        token!,
      );
      print(val.toString());
      return val;
    } catch (error) {
      print(error.toString());
      Fluttertoast.showToast(msg: error.toString());
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      throw Future.error(error);

    }
  }
}
