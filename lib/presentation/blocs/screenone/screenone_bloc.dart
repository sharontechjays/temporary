// toggle_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

enum ToggleState { OFF, ON }

abstract class ToggleEvent {}

class ToggleButtonPressed extends ToggleEvent {}

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  ToggleBloc() : super(ToggleState.OFF) {
    on<ToggleButtonPressed>(_onToggleButtonPressed);
  }

  void _onToggleButtonPressed(ToggleButtonPressed event, Emitter<ToggleState> emit) {
    emit(state == ToggleState.OFF ? ToggleState.ON : ToggleState.OFF);
  }
}
