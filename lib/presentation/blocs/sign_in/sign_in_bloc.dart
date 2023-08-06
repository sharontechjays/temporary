import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/login_services.dart';
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
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(SignInFailure(error: "Username/password is empty"));
      } else {
        var result =
            await LoginServices().loginUser(event.email, event.password);
        if (result.result) {
          emit(SignInSuccess(message: result.data!));
        } else {
          emit(SignInFailure(error: result.msg));
        }
      }
    }
  }
}
