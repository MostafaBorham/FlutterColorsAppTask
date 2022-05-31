abstract class ColorsState{}
////////////////////////////////////////////////////
class ColorsInitialState extends ColorsState{}
class HideSecondTextFieldState extends ColorsState{}
class ShowSecondTextFieldState extends ColorsState{}
class NoErrorColorState extends ColorsState{}
class ErrorColorState extends ColorsState{
  final String message;

  ErrorColorState(this.message);
}
class GetAutoCompleteSuggestionsState extends ColorsState{
  final List<String> suggestions;

  GetAutoCompleteSuggestionsState(this.suggestions);
}
class GetDefaultColorState extends ColorsState{
  final String defaultColor;

  GetDefaultColorState(this.defaultColor);
}
class SendBtnStatusChangedState extends ColorsState{
  final bool isEnabled;

  SendBtnStatusChangedState(this.isEnabled);
}