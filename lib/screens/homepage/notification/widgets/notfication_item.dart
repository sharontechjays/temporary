import 'package:flutter/material.dart';

import '../../../../models/notifications.dart' as ItemNoti;

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
            backgroundColor: Colors.white,
            radius: 25.0,
            child: Image.network(
              mProfilePic != null && mProfilePic.isNotEmpty
                  ? notification.sentByUser!.mediumProfileImg!
                  : 'https://force-field-dev.s3.amazonaws.com/common/images/default_user_image.png',
            ),
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
