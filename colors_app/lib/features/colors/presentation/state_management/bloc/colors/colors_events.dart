abstract class ColorsEvent{}
//////////////////////////////////////////////////////////////
class ColorStartedWithAEvent extends ColorsEvent{}
class CheckIfErrorColorEvent extends ColorsEvent{
  final String color;

  CheckIfErrorColorEvent(this.color);
}
class GetAutoCompleteSuggestionsEvent extends ColorsEvent{}
class GetDefaultColorEvent extends ColorsEvent{}
class ColorNotStartedWithAEvent extends ColorsEvent{}
class ChangeSendBtnStatusEvent extends ColorsEvent{
  final bool isEnabled;

  ChangeSendBtnStatusEvent(this.isEnabled);
}