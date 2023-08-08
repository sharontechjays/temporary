import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/presentation/utils/utils.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {
      if (event is SignUpButtonPressed) {
        String validatedString = Utils().validateEmail(event.email);
        if (validatedString.isNotEmpty) {
          emit(SignupFailure(error: validatedString));
        } else {
          emit(SignUpSuccess(message: "success"));
        }
      }
    });
  }
}
