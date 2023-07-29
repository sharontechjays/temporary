import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/products_model.dart';
import '../../../data/services/product_services.dart';
import 'products_event.dart';
import 'products_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, ProductsState> {
  NotificationsBloc() : super(ProductsInitial()) {
    on<FetchNotifications>(_onFetchNotifications);
  }

  List<Products> products = [];
  int offset = 0;
  int limit = 5;
  bool isNextLink = true;

  void _onFetchNotifications(
    FetchNotifications event,
    Emitter<ProductsState> emit,
  ) async {
    if (isNextLink) {
      try {
        emit(ProductsLoading());
        offset = event.offset;
        limit = event.limit;
        final newProducts = await ProductServices().getProducts();
        debugPrint("offset-->${newProducts.data!.products.length}");
        if (isNextLink && newProducts.data!.products.isNotEmpty) {
          products.addAll(newProducts.data!.products);
        }
        if (products.isNotEmpty) {
          isNextLink = false;
        }
        emit(ProductsLoaded(products));
        if (newProducts.data!.products.isEmpty && offset == 0) {
          emit(const ProductsEmpty("No Notifications"));
        }
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    }
  }
}
