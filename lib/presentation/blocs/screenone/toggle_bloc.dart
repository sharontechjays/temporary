// toggle_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/presentation/blocs/screenone/toggle_event.dart';
import 'package:test_flutter/presentation/blocs/screenone/toggle_state.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  ToggleBloc() : super(ToggleState.OFF) {
    on<ToggleButtonPressed>(_onToggleButtonPressed);
  }

  void _onToggleButtonPressed(
      ToggleButtonPressed event, Emitter<ToggleState> emit) {
    if (event.index == 0) {
      emit(ToggleState.OFF);
    } else {
      emit(ToggleState.ON);
    }
    //emit(state == ToggleState.OFF ? ToggleState.ON : ToggleState.OFF);
  }
}
