import 'package:flutter_bloc/flutter_bloc.dart';

import 'homepage_event.dart';
import 'homepage_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(0)) {
    on<NavigationEvent>(_onNavigationEvent);
  }

  void _onNavigationEvent(
      NavigationEvent event, Emitter<NavigationState> emit) async {
    int currentIndex = 0;

    if (event == NavigationEvent.screenOneSelected) {
      currentIndex = 0;
    } else if (event == NavigationEvent.screenTwoSelected) {
      currentIndex = 1;
    } else if (event == NavigationEvent.screenThreeSelected) {
      currentIndex = 2;
    }
    emit(NavigationState(currentIndex));
  }
}
