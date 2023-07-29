import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/models/api_response.dart';
import 'package:test_flutter/models/products_model.dart';
import 'package:test_flutter/services/notfication_services.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<FetchNotifications>(_onFetchNotifications);
  }

  List<Products> products = [];
  int offset = 0;
  int limit = 5;
  bool isNextLink = true;

  void _onFetchNotifications(
    FetchNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    if (isNextLink) {
      try {
        emit(NotificationsLoading());
        offset = event.offset;
        limit = event.limit;
        final newProducts = await ProductServices().getProducts();
        debugPrint("offset-->${newProducts.data!.products.length}");
        if (isNextLink && newProducts.data!.products.isNotEmpty) {
          products.addAll(newProducts.data!.products);
        }
        if (offset >= 30) {
          isNextLink = false;
        }
        emit(NotificationsLoaded(products));
        if (newProducts.data!.products.isEmpty && offset == 0) {
          emit(const NotificationEmpty("No Notifications"));
        }
      } catch (e) {
        emit(NotificationsError(e.toString()));
      }
    }
  }
}
