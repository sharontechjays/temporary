import 'package:equatable/equatable.dart';
import 'package:test_flutter/models/products_model.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Products> products;

  const ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object> get props => [message];
}
class ProductsEmpty extends ProductsState {
  final String message;

  const ProductsEmpty(this.message);

  @override
  List<Object> get props => [message];
}
