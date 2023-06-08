import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/models/notifications.dart' as MyNotifications;
import 'package:test_flutter/widgets/notfication_item.dart';

import '../../models/notifications.dart';
import '../../services/notfication_services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int offset = 0;
  int limit = 10;
  bool isLoading = false;
  bool isNextLink = false;
  List<MyNotifications.Data> mData = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  var json = {"offset": 0, "limit": 1000};

  Future<Notifications> loadData() async {
    return NotificationServices().getNotifications(context, json).then((value) {
      if (value.result!) {
        setState(() {
          mData.clear();
          if (offset == 0) {
            mData.addAll(value.data!);
          } else {
            mData.add(value.data! as MyNotifications.Data);
          }
        });
      } else {
        Fluttertoast.showToast(msg: value.msg!);
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView.builder(
        itemCount: mData.length,
        itemBuilder: (context, index) {
          final notification = mData[index];
          return NotificationItem(notification: notification);
        },
      ),
    );
  }
}
