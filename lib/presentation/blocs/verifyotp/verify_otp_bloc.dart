import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/presentation/blocs/verifyotp/verify_otp_event.dart';
import 'package:test_flutter/presentation/blocs/verifyotp/verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitial()) {
    on<VerifyOtpEvent>((event, emit) {
      if (event is VerifyOtpButtonPressed) {
        emit(VerifyOTPSuccess(message: ""));
      }
    });
  }
}
