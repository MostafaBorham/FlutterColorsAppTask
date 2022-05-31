// ignore_for_file: must_be_immutable

import 'package:colors_app/core/app_resources/app_constants.dart';
import 'package:colors_app/core/app_resources/app_strings.dart';
import 'package:colors_app/core/app_resources/app_values.dart';
import 'package:colors_app/core/widgets/custom_button.dart';
import 'package:colors_app/core/widgets/custom_text_form_field.dart';
import 'package:colors_app/features/colors/presentation/pages/print_colors_page/main_page.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_bloc.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_resources/app_colors.dart';
import '../../state_management/bloc/colors/colors_states.dart';

class UserColorsForm extends StatelessWidget {
  final _formedKey = GlobalKey<FormState>();
  final _firstTextFieldController = TextEditingController();
  final _secondTextFieldController = TextEditingController();
  final _thirdTextFieldController = TextEditingController();
  final _forthTextFieldController = TextEditingController();
  bool _isSecondTextFieldEnabled = true;
  String? _currentErrorTextOfSecondTextField;
  List<String> suggestions = [];
  UserColorsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        leading: const Icon(Icons.app_registration),
        title: const Text(COLORS_FORM_TITLE),
        backgroundColor: PRIMARY,
      );
  Widget _buildBody(context) => Padding(
        padding: const EdgeInsets.all(AppPadding.P10),
        child: Center(
          child: BlocConsumer<ColorsBloc, ColorsState>(
            listener: (context, state) {
              if (state is GetAutoCompleteSuggestionsState) {
                suggestions = state.suggestions;
              }
            },
            builder: (context, state) {
              if (state is GetDefaultColorState) {
                _forthTextFieldController.text = state.defaultColor;
              }
              return Form(
                key: _formedKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCustomTextForm(
                          controller: _firstTextFieldController,
                          context: context,
                          label: 'FirstTextField',
                          maxLength: 9,
                          autoFocus: true,
                          validator: (input) =>
                              _validateFirstTextField(input, context),
                          key: _formedKey),
                      const SizedBox(
                        height: AppDimension.D15,
                      ),
                      buildCustomTextForm(
                          controller: _secondTextFieldController,
                          context: context,
                          label: 'SecondTextField',
                          enabled: _controlInDisplaySecondTextField(state),
                          maxLength: 9,
                          errorText: _getErrorTextOfSecondTextField(state),
                          validator: (input) =>
                              _validateSecondTextField(input, context,state),
                          key: _formedKey),
                      const SizedBox(
                        height: AppDimension.D15,
                      ),
                      buildAutoCompleteTextField(
                          controller: _thirdTextFieldController,
                          context: context,
                          label: 'ThirdTextField',
                          maxLength: 9,
                          suggestions: suggestions,
                          validator: (input) =>
                              _validateThirdTextField(input, context),
                          key: _formedKey),
                      const SizedBox(
                        height: AppDimension.D15,
                      ),
                      buildCustomTextForm(
                          controller: _forthTextFieldController,
                          context: context,
                          label: 'ForthTextField',
                          maxLength: 20,
                          validator: (input) =>
                              _validateForthTextField(input, context),
                          key: _formedKey),
                      const SizedBox(
                        height: AppDimension.D30,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: buildCustomButton(
                              onPressed: state is SendBtnStatusChangedState
                                  ? (state.isEnabled
                                      ? () => _sendColorsData(context)
                                      : null)
                                  : null,
                              text: 'Send'))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );

  _sendColorsData(context) {
    final colorsFormList = [
      _firstTextFieldController.text,
      _secondTextFieldController.text,
      _thirdTextFieldController.text,
      _forthTextFieldController.text
    ];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PrintColorsPage(colorsFormData: colorsFormList)));
  }

  String? validateInput(String input, int minLength) {
    if (input.isEmpty) {
      return 'must be fill !';
    } else if (input.length < minLength) {
      return 'must be length between $minLength and 9 digits';
    } else {
      return null;
    }
  }

  String? isStartedWithA(context, String input) {
    if (input.startsWith('a')) {
      BlocProvider.of<ColorsBloc>(context).add(ColorStartedWithAEvent());
      return 'must not start with a';
    }
    return null;
  }

  bool _controlInDisplaySecondTextField(ColorsState state) {
    if (state is HideSecondTextFieldState) {
      return _isSecondTextFieldEnabled = false;
    } else if (state is ShowSecondTextFieldState) {
      return _isSecondTextFieldEnabled = true;
    } else {
      return _isSecondTextFieldEnabled;
    }
  }

  String? _getErrorTextOfSecondTextField(ColorsState state) {
    if (state is ErrorColorState) {
      _formedKey.currentState!.validate();
      return _currentErrorTextOfSecondTextField = state.message;
    } else if (state is NoErrorColorState) {
      _formedKey.currentState!.validate();
      return _currentErrorTextOfSecondTextField = null;
    } else {
      return _currentErrorTextOfSecondTextField;
    }
  }

  String? _validateFirstTextField(input, context) {
    String? result = isStartedWithA(context, input!);
    if (result != null) {
      return result;
    } else {
      BlocProvider.of<ColorsBloc>(context).add(ColorNotStartedWithAEvent());
      return validateInput(input, MIN_LENGTH_6);
    }
  }

  String? _validateSecondTextField(input, context,state) {
    String? result = validateInput(input, MIN_LENGTH_3);
    if (result == null) {
      if(state is! ErrorColorState || state is! NoErrorColorState){
        BlocProvider.of<ColorsBloc>(context).add(CheckIfErrorColorEvent(input));
      }
      result= _currentErrorTextOfSecondTextField;
    }
    return result;
  }

  String? _validateThirdTextField(input, context) {
    String? result = validateInput(input, MIN_LENGTH_3);
    return result;
  }

  String? _validateForthTextField(input, context) {
    String? result = validateInput(input, MIN_LENGTH_3);
    return result;
  }
}
