import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/blocs/notifications/notfication_event.dart';

import 'package:test_flutter/models/notifications.dart' as MyNotifications;
import 'package:test_flutter/utils.dart';

import '../../network_service/rest_client.dart';
import '../../services/notfication_services.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final BuildContext context;
  int offset;
  final int limit;
  final List<MyNotifications.Data> mData;
  bool _isLoadingNextPage=true; // Flag to indicate if loading the next page is in progress

  NotificationBloc({
    required this.context,
    required this.offset,
    required this.limit,
    required this.mData,
  }) : super(NotificationInitialState()) {
    _isLoadingNextPage = false; // Initialize the flag to false
    on<LoadNotificationEvent>(_onLoadNotificationEvent);
    on<LoadMoreNotificationEvent>(_onLoadMoreNotificationEvent);
  }

  Future<void> _onLoadNotificationEvent(
      LoadNotificationEvent event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      final notificationServices = NotificationServices(
        RestClient.create(),
        Utils(),
      );

      final value =
      await notificationServices.getNotifications(context, offset, limit);

      var util = Utils();
      final responseString = jsonEncode(value.toJson());
      final formattedResponse = util.prettyPrint(responseString);
      debugPrint('API Response: $formattedResponse');

      if (value.result!) {
        if (offset == 0) {
          mData.clear();
        }

        mData.addAll(value.data!);

        if (value.nextLink!) {
          offset += limit;
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

  Future<void> _onLoadMoreNotificationEvent(
      LoadMoreNotificationEvent event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      if (_isLoadingNextPage) return; // Check if loading is already in progress

      _isLoadingNextPage = true; // Set the flag to indicate loading

      final notificationServices = NotificationServices(
        RestClient.create(),
        Utils(),
      );

      final value =
      await notificationServices.getNotifications(context, offset, limit);

      var util = Utils();
      offset += limit;
      final responseString = jsonEncode(value.toJson());
      final formattedResponse = util.prettyPrint(responseString);
      debugPrint('API loadmore: $formattedResponse');

      if (value.result!) {
        if (value.nextLink!) {
          offset += limit;
        }

        mData.addAll(value.data!);

        emit(NotificationLoadedState(mData, value.nextLink!));
      } else {
        Fluttertoast.showToast(msg: value.msg!);
      }
    } catch (error) {
      emit(NotificationErrorState(error.toString()));
    } finally {
      _isLoadingNextPage = false; // Reset the flag after loading is completed
    }
  }
}
