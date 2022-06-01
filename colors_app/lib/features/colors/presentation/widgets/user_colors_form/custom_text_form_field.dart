import 'package:colors_app/core/app_resources/app_constants.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_bloc.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../../core/app_resources/app_values.dart';

TextFormField buildCustomTextForm({
  required TextEditingController controller,
  required BuildContext context,
  String? label,
  double? padding,
  int? minLines,
  int maxLines = 1,
  int? maxLength,
  bool enabled = true,
  bool autoFocus = false,
  String? errorText,
  ValueChanged? onChanged,
  FormFieldValidator<String>? validator,
  required GlobalKey<FormState> key,
}) =>
    TextFormField(
      controller: controller,
      enabled: enabled,
      autofocus: autoFocus,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.S5)),
          ),
          label: label != null ? Text(label) : null,
          errorText: errorText,
          contentPadding: EdgeInsets.symmetric(
              vertical: padding ?? AppPadding.P10, horizontal: AppPadding.P10)),
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged ??
          (input) {
            if (key.currentState!.validate()) {
              BlocProvider.of<ColorsBloc>(context)
                  .add(ChangeSendBtnStatusEvent(TRUE));
            } else {
              BlocProvider.of<ColorsBloc>(context)
                  .add(ChangeSendBtnStatusEvent(FALSE));
            }
          },
      validator: validator,
    );

Widget buildAutoCompleteTextField(
        {required TextEditingController controller,
        required BuildContext context,
        String? label,
        double? padding,
        int? minLines,
        int maxLines = 1,
        int? maxLength,
        bool enabled = true,
        bool autoFocus = false,
        String? errorText,
        ValueChanged? onChanged,
        required List<String> suggestions,
        required GlobalKey<FormState> key,
        FormFieldValidator<String>? validator}) =>
    TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.S5)),
            ),
            label: label != null ? Text(label) : null,
            errorText: errorText,
            contentPadding: EdgeInsets.symmetric(
                vertical: padding ?? AppPadding.P10,
                horizontal: AppPadding.P10)),
        controller: controller,
        enabled: enabled,
        autofocus: autoFocus,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged ??
            (input) {
              if (key.currentState!.validate()) {
                BlocProvider.of<ColorsBloc>(context)
                    .add(ChangeSendBtnStatusEvent(TRUE));
              } else {
                BlocProvider.of<ColorsBloc>(context)
                    .add(ChangeSendBtnStatusEvent(FALSE));
              }
            },
      ),
      suggestionsCallback: (pattern) => suggestions,
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.toString()),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller.text = suggestion.toString();
        key.currentState!.validate();
      },
      validator: validator,
    );
