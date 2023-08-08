import 'package:equatable/equatable.dart';

abstract class VerifyOtpEvent extends Equatable {}

class VerifyOtpButtonPressed extends VerifyOtpEvent {
  final String pin;

  VerifyOtpButtonPressed({required this.pin});

  @override
  List<Object> get props => [pin];
}
