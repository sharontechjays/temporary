import 'package:flutter/material.dart';

import '../models/notifications.dart' as ItemNoti;

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  final ItemNoti.Data notification;

  @override
  Widget build(BuildContext context) {
    var mProfilePic = notification.sentByUser?.mediumProfileImg;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            child: mProfilePic!.isNotEmpty
                ? Image.network(notification.sentByUser!.mediumProfileImg!)
                : Center(
                    child: Text(notification.notificationData!.mobileNumber!
                        .toString())),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            notification.message!,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ))
        ],
      ),
    );
  }
}
