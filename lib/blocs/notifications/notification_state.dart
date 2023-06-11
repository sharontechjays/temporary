import 'notfication_bloc.dart';
import 'package:test_flutter/models/notifications.dart' as MyNotifications;

abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final List<MyNotifications.Data> notifications;

  NotificationLoadedState(this.notifications);
}

class NotificationErrorState extends NotificationState {
  final String error;

  NotificationErrorState(this.error);
}
