abstract class ToggleEvent {}

class ToggleButtonPressed extends ToggleEvent {
  final int index;

  ToggleButtonPressed(this.index);
}
