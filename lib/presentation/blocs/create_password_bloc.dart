import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_password_event.dart';

part 'create_password_state.dart';

class CreatePasswordBloc
    extends Bloc<CreatePasswordEvent, CreatePasswordState> {
  CreatePasswordBloc() : super(CreatePasswordInitial()) {
    on<CreatePasswordEvent>((event, emit) {
      if (event is CreatePasswordButtonPressed) {
        emit(CreatePasswordSuccess(message: ""));
      }
    });
  }
}
