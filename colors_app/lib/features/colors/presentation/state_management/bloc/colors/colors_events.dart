abstract class ColorsEvent {}

//////////////////////////////////////////////////////////////
class ColorStartedWithAEvent extends ColorsEvent {}

class GetAllErrorColors extends ColorsEvent {}

class GetAutoCompleteSuggestionsEvent extends ColorsEvent {}

class GetDefaultColorEvent extends ColorsEvent {}

class ColorNotStartedWithAEvent extends ColorsEvent {}

class ChangeSendBtnStatusEvent extends ColorsEvent {
  final bool isEnabled;

  ChangeSendBtnStatusEvent(this.isEnabled);
}
