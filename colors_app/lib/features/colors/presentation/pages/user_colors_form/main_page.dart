// ignore_for_file: must_be_immutable

import 'package:colors_app/core/app_resources/app_constants.dart';
import 'package:colors_app/core/app_resources/app_strings.dart';
import 'package:colors_app/core/app_resources/app_values.dart';
import 'package:colors_app/core/widgets/custom_button.dart';
import 'package:colors_app/features/colors/presentation/widgets/user_colors_form/custom_text_form_field.dart';
import 'package:colors_app/features/colors/data/models/async_validation_colors.dart';
import 'package:colors_app/features/colors/presentation/pages/print_colors_page/main_page.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_bloc.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_resources/app_colors.dart';
import '../../state_management/bloc/colors/colors_states.dart';

class UserColorsForm extends StatelessWidget {
  ////////////////Variables
  final _formedKey = GlobalKey<FormState>();
  final _firstTextFieldController = TextEditingController();
  final _secondTextFieldController = TextEditingController();
  final _thirdTextFieldController = TextEditingController();
  final _forthTextFieldController = TextEditingController();
  List<AsyncValidationColorsModel> errorColorsList = [];
  bool _isSecondTextFieldEnabled = true;
  bool _isSendBtnEnabled = false;
  List<String> suggestions = [];
  ////////////////Constructors
  UserColorsForm({Key? key}) : super(key: key);

  /////////////Build Function -> start of screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  //////////////////////////////////Scaffold Components Methods
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
              if (state is GetDefaultColorState) {
                _forthTextFieldController.text = state.defaultColor;
                _formedKey.currentState!.validate();
              } else if (state is GetAutoCompleteSuggestionsState) {
                suggestions = state.suggestions;
              } else if (state is GetAllErrorColorsState) {
                errorColorsList = state.errorColorsList;
              } else if (state is SendBtnStatusChangedState) {
                _isSendBtnEnabled = state.isEnabled;
              }
            },
            builder: (context, state) {
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
                        //errorText: _getErrorTextOfSecondTextField(state),
                        validator: (input) =>
                            _validateSecondTextField(input, context),
                        key: _formedKey,
                      ),
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
                              onPressed: _isSendBtnEnabled
                                  ? () => _sendColorsData(context)
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

  ///////////////////////////////Private Class Methods
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

  String? _validateInput(String input, int minLength) {
    if (input.isEmpty) {
      return 'must be fill !';
    } else if (input.length < minLength) {
      return 'must be length between $minLength and 9 digits';
    } else {
      return null;
    }
  }

  String? _isStartedWithA(context, String input) {
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

  String? _validateFirstTextField(input, context) {
    String? result = _isStartedWithA(context, input!);
    if (result != null) {
      return result;
    } else {
      BlocProvider.of<ColorsBloc>(context).add(ColorNotStartedWithAEvent());
      return _validateInput(input, MIN_LENGTH_6);
    }
  }

  String? _validateSecondTextField(input, context) {
    String? result = _validateInput(input, MIN_LENGTH_3);
    if (result == null) {
      for (var element in errorColorsList) {
        if (element.color == input) {
          return element.errorMessage;
        }
      }
    }
    return result;
  }

  String? _validateThirdTextField(input, context) {
    String? result = _validateInput(input, MIN_LENGTH_3);
    return result;
  }

  String? _validateForthTextField(input, context) {
    String? result = _validateInput(input, MIN_LENGTH_3);
    return result;
  }
}
