import 'package:flutter/material.dart';
import '../app_resources/app_colors.dart';
import '../app_resources/app_values.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Divider(
        thickness: AppSize.S2,
        color: PRIMARY,
      ),
    );
  }
}