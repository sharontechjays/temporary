import 'package:flutter_bloc/flutter_bloc.dart';

enum TabState { FOUR_TABS, THREE_TABS }

class TabToggleEvent {}

class TabButtonPressed extends TabToggleEvent {}

class TabSelected extends TabToggleEvent {
  final int index;

  TabSelected(this.index);
}

class TabToggleBloc extends Bloc<TabToggleEvent, TabState> {
  TabToggleBloc() : super(TabState.FOUR_TABS) {
    on<TabButtonPressed>(_onTabButtonPressed);
    on<TabSelected>(_onTabSelected);
  }

  void _onTabButtonPressed(TabButtonPressed event, Emitter<TabState> emit) {
    emit(
        state == TabState.FOUR_TABS ? TabState.THREE_TABS : TabState.FOUR_TABS);
  }

  void _onTabSelected(TabSelected event, Emitter<TabState> emit) {
    emit(state);
  }
}
