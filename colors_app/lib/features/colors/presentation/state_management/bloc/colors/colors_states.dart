import 'package:colors_app/features/colors/data/models/async_validation_colors.dart';

abstract class ColorsState {}

////////////////////////////////////////////////////
class ColorsInitialState extends ColorsState {}

class HideSecondTextFieldState extends ColorsState {}

class ShowSecondTextFieldState extends ColorsState {}

class GetAllErrorColorsState extends ColorsState {
  final List<AsyncValidationColorsModel> errorColorsList;

  GetAllErrorColorsState(this.errorColorsList);
}

class GetAutoCompleteSuggestionsState extends ColorsState {
  final List<String> suggestions;

  GetAutoCompleteSuggestionsState(this.suggestions);
}

class GetDefaultColorState extends ColorsState {
  final String defaultColor;

  GetDefaultColorState(this.defaultColor);
}

class SendBtnStatusChangedState extends ColorsState {
  final bool isEnabled;

  SendBtnStatusChangedState(this.isEnabled);
}
