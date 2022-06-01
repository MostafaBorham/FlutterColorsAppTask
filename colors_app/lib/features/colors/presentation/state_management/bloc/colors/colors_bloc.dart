import 'package:bloc/bloc.dart';
import 'package:colors_app/core/app_resources/app_constants.dart';
import 'package:colors_app/core/app_resources/app_strings.dart';
import 'package:colors_app/features/colors/domain/uses_case/get_auto_suggestions_colors.dart';
import 'package:colors_app/features/colors/domain/uses_case/get_error_colors.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_events.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_states.dart';

import '../../../../domain/uses_case/get_default_color.dart';

class ColorsBloc extends Bloc<ColorsEvent, ColorsState> {
  final GetErrorColorsUseCase errorColorsUseCase;
  final GetAutoSuggestionsColorsUseCase autoSuggestionsColorsUseCase;
  final GetDefaultColorUseCase defaultColorUseCase;
  ColorsBloc(
      {required this.defaultColorUseCase,
      required this.autoSuggestionsColorsUseCase,
      required this.errorColorsUseCase})
      : super(ColorsInitialState()) {
    on<ColorsEvent>((event, emit) async {
      if (event is ColorStartedWithAEvent) {
        emit(HideSecondTextFieldState());
      } else if (event is ColorNotStartedWithAEvent) {
        emit(ShowSecondTextFieldState());
      } else if (event is GetAllErrorColors) {
        final response = await errorColorsUseCase();
        response.fold((failure) => emit(GetAllErrorColorsState([])),
            (colorErrorList) {
          emit(GetAllErrorColorsState(colorErrorList));
        });
      } else if (event is GetAutoCompleteSuggestionsEvent) {
        final response = await autoSuggestionsColorsUseCase();
        response.fold(
          (failure) => emit(GetAutoCompleteSuggestionsState([])),
          (suggestions) => emit(GetAutoCompleteSuggestionsState(suggestions)),
        );
      } else if (event is GetDefaultColorEvent) {
        final response = await defaultColorUseCase();
        response.fold(
          (failure) => emit(GetDefaultColorState(EMPTY)),
          (defaultColor) => emit(GetDefaultColorState(defaultColor)),
        );
      } else if (event is ChangeSendBtnStatusEvent) {
        emit(SendBtnStatusChangedState(event.isEnabled));
      }
    });
  }
}
