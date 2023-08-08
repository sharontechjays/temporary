part of 'create_password_bloc.dart';

abstract class CreatePasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatePasswordInitial extends CreatePasswordState {}

class CreatePasswordSuccess extends CreatePasswordState {
  @override
  List<Object> get props => [];

  final String message;

  CreatePasswordSuccess({required this.message});
}

class CreatePasswordFailure extends CreatePasswordState {
  @override
  List<Object> get props => [];

  final String error;

  CreatePasswordFailure({required this.error});
}

class CreatePasswordLoading extends CreatePasswordState {}
