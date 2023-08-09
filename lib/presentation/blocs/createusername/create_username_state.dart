part of 'create_username_bloc.dart';

abstract class CreateUsernameState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateUsernameInitial extends CreateUsernameState {}

class CreateUsernameSuccess extends CreateUsernameState {
  final String message;

  CreateUsernameSuccess({required this.message});

  @override
  List<Object> get props => [];
}

class CreateUsernameFailure extends CreateUsernameState {
  final String error;

  CreateUsernameFailure({required this.error});

  @override
  List<Object> get props => [];
}
