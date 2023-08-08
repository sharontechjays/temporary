part of 'verify_otp_bloc.dart';

abstract class VerifyOtpState extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOTPSuccess extends VerifyOtpState {
  final String message;

  VerifyOTPSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class VerifyOTPFailure extends VerifyOtpState {
  final String error;

  VerifyOTPFailure({required this.error});

  @override
  List<Object> get props => [error];
}
