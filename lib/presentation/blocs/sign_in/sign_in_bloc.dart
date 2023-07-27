import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>(_onSignInEventHappened);
  }

  void _onSignInEventHappened(
    SignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    if (event is SignInButtonPressed) {
      emit(SignInLoading());
      await Future.delayed(const Duration(seconds: 2));
      if (event.email == 'example@example.com' &&
          event.password == 'password') {
        emit(SignInSuccess(message: 'Sign-in successful!'));
      } else {
        emit(SignInFailure(error: 'Invalid credentials.'));
      }
    }
  }
}
