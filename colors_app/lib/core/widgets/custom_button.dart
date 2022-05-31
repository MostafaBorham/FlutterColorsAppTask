import 'package:flutter/material.dart';

import '../app_resources/app_colors.dart';

ElevatedButton buildCustomButton(
        {required VoidCallback? onPressed,
        required String text,
        Color color = PRIMARY}) =>
    ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
