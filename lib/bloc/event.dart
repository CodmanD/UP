abstract class PinEvent {}

class SubmitEvent extends PinEvent {
  String pin;

  SubmitEvent(this.pin);
}

class RepeatEvent extends PinEvent {}
