import 'dart:convert';
import 'package:colors_app/features/colors/data/models/user_colors.dart';
import 'package:flutter/services.dart';

abstract class ColorsLocalDataSource {
  Future<UserColorsModel> getColorsData();
}

class ColorsLocalDataSourceJsonFile extends ColorsLocalDataSource {
  @override
  Future<UserColorsModel> getColorsData() async {
    UserColorsModel? returnedValue;
    await rootBundle.loadString('assets/json_files/colors.json').then((value) {
      Map<String, dynamic> colorsDataMap =
          json.decode(value); //convert json string to map of colorsData
      returnedValue = UserColorsModel.fromJson(colorsDataMap);
    });
    return returnedValue!;
  }
}
