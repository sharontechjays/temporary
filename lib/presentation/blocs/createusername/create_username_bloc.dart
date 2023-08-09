import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_username_event.dart';

part 'create_username_state.dart';

class CreateUsernameBloc
    extends Bloc<CreateUsernameEvent, CreateUsernameState> {
  CreateUsernameBloc() : super(CreateUsernameInitial()) {
    on<CreateUsernameEvent>((event, emit) {
      if (event is CreateUsernameAvailability) {
        if (event.username.contains(" ")) {
          emit(
              CreateUsernameFailure(error: "username shouldn't contain space"));
        } else {
          emit(CreateUsernameSuccess(message: "username Available"));
        }
      }
      else {
        emit(CreateUsernameSuccess(message: "username Available"));
      }
    });
  }
}
