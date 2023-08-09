part of 'create_username_bloc.dart';

abstract class CreateUsernameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateUsernameButtonPressed extends CreateUsernameEvent {
  final String username;

  CreateUsernameButtonPressed({required this.username});

  @override
  List<Object> get props => [username];
}

class CreateUsernameAvailability extends CreateUsernameEvent {
  final String username;

  CreateUsernameAvailability({required this.username});

  @override
  List<Object> get props => [username];
}
