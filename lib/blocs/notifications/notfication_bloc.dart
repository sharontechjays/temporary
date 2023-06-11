import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/blocs/notifications/notfication_event.dart';
import 'package:test_flutter/models/notifications.dart' as MyNotifications;
import 'package:test_flutter/services/notfication_services.dart';
import 'package:test_flutter/utils.dart';

import '../../network_service/rest_client.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final BuildContext context;
  final int offset;
  final int limit;
  final List<MyNotifications.Data> mData;

  NotificationBloc({
    required this.context,
    required this.offset,
    required this.limit,
    required this.mData,
  }) : super(NotificationInitialState()) {
    on<LoadNotificationEvent>(_onLoadNotificationEvent);
  }

  Future<void> _onLoadNotificationEvent(
    LoadNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      debugPrint('API Call: getNotifications');
      final json = {'offset': offset, 'limit': limit};
      debugPrint('Parameters: $json');

      final notificationServices = NotificationServices(
        RestClient.create(),
        Utils(),
      );

      final value = await notificationServices.getNotifications(context, json);

      var util = Utils();
      final responseString = jsonEncode(value.toJson());
      final formattedResponse = util.prettyPrint(responseString);
      debugPrint('API Response: $formattedResponse');
      if (value.result!) {
        mData.clear();
        if (offset == 0) {
          mData.addAll(value.data!);
        } else {
          mData.add(value.data! as MyNotifications.Data);
        }

        emit(NotificationLoadedState(mData, value.nextLink!));
      } else {
        Fluttertoast.showToast(msg: value.msg!);
        emit(NotificationErrorState(value.msg!));
      }
    } catch (error) {
      emit(NotificationErrorState(error.toString()));
    }
  }
}
