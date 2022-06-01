import 'package:colors_app/core/widgets/list_divider.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_resources/app_colors.dart';
import '../../../../../core/app_resources/app_strings.dart';
import '../../../../../core/app_resources/app_values.dart';

class PrintColorsPage extends StatelessWidget {
  final List<String> colorsFormData;
  const PrintColorsPage({Key? key, required this.colorsFormData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text(PRINT_COLORS_FORM_TITLE),
        backgroundColor: PRIMARY,
      );

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(AppPadding.P10),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      _buildItemList(colorsFormData[index]),
                  separatorBuilder: (context, index) => const ListDivider(),
                  itemCount: colorsFormData.length),
            ),
          ],
        ),
      );

  Widget _buildItemList(title) => ListTile(
        leading: const Icon(
          Icons.color_lens,
          color: PRIMARY,
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.check_circle,
          color: SUCCESS,
        ),
      );
}
