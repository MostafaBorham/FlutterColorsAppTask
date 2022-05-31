import 'package:colors_app/features/colors/data/models/group_of_colors.dart';

const String redTitleJsonKey = 'red';
const String colorsGroupJsonKey = 'groupOfColors';

class UserColorsModel {
  String? red;
  GroupOfColorsModel? groupOfColors;

  UserColorsModel({this.red, this.groupOfColors});

  UserColorsModel.fromJson(Map<String, dynamic> json) {
    red = json[redTitleJsonKey];
    groupOfColors = json[colorsGroupJsonKey] != null
        ? GroupOfColorsModel.fromJson(json[colorsGroupJsonKey])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[redTitleJsonKey] = red;
    if (groupOfColors != null) {
      data[colorsGroupJsonKey] = groupOfColors!.toJson();
    }
    return data;
  }
}
