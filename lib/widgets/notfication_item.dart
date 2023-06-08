import 'package:flutter/material.dart';

import '../models/notifications.dart' as ItemNoti;

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  final ItemNoti.Data notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Expanded(child: Text(notification.message!))],
    );
  }
}
