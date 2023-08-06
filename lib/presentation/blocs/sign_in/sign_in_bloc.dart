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
      if (_isValidated(event).isNotEmpty) {
        emit(SignInFailure(error: _isValidated(event)));
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

  String _isValidated(SignInButtonPressed event) {
    String validationString = "";
    if (event.email.isEmpty || event.password.isEmpty) {
      validationString = "username/ password is empty";
    } else if (event.email.length < 6 || event.password.length < 6) {
      validationString =
          "email and password should contain more than 6 characters";
    } else {}
    return validationString;
  }
}
