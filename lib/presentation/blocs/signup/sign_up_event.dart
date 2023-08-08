part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String email;

  SignUpButtonPressed({required this.email});

  @override
  List<Object> get props => [email];
}
