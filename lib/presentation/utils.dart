import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/data/SharedPreferencesHelper.dart';

class Utils {
  String getSecretKey() {
    return "gAAAAABju5HOav4K3tq1rCVSBKb20t7-Ha5P9o9OOVlnfnL9LuxtxNYEsVeD58YwXD5KXVBF3l_jBjagg86SceIgA4N6vhh57IpAvMmmEHRY0dnzsHoZYLWtVTkjq8t7GUbkkHXYol88Gj7Z1RpjXfnFkesL3vuWKA==";
  }

  Future<String?> getToken(BuildContext context) async {
    await SharedPreferencesHelper.init();
    var token = await SharedPreferencesHelper.getString('token');
    debugPrint(token);
    return token;
  }

  String prettyPrint(String input) {
    dynamic json = const JsonDecoder().convert(input);
    return const JsonEncoder.withIndent('  ').convert(json);
  }

  String getPlatformName() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Unknown Platformq';
    }
  }

  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.androidId; // Android device ID
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // iOS device ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
