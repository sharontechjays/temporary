import 'package:equatable/equatable.dart';
import 'package:test_flutter/data/models/login_model.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final LoginModel message;

  SignInSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure({required this.error});

  @override
  List<Object> get props => [error];
}
