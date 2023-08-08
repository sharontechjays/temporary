part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;

  SignUpSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SignupFailure extends SignUpState {
  final String error;

  SignupFailure({required this.error});

  @override
  List<Object> get props => [error];
}
