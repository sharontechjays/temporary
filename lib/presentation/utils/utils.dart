import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_flutter/data/SharedPreferencesHelper.dart';

class Utils {
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
      return 'Unknown Platform';
    }
  }

  Image buildImage(String url) {
    return Image.network(
      url,
      cacheWidth: 100,
      cacheHeight: 100,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

/*  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}*/

}
