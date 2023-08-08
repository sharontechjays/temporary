part of 'create_password_bloc.dart';

abstract class CreatePasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatePasswordButtonPressed extends CreatePasswordEvent {
  final String password;
  final String confirmPassword;

  CreatePasswordButtonPressed(
      {required this.password, required this.confirmPassword});

  @override
  List<Object> get props => [password, confirmPassword];
}
