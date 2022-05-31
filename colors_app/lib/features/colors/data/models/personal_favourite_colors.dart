import 'package:colors_app/features/colors/data/models/add_to_these_colors.dart';

const String addToTheseColorsJsonKey = 'addToTheseColors';

class PersonalFavoriteColorsModel {
  List<AddToTheseColorsModel>? addToTheseColors;

  PersonalFavoriteColorsModel({this.addToTheseColors});

  PersonalFavoriteColorsModel.fromJson(Map<String, dynamic> json) {
    if (json[addToTheseColorsJsonKey] != null) {
      addToTheseColors = <AddToTheseColorsModel>[];
      json[addToTheseColorsJsonKey].forEach((v) {
        addToTheseColors!.add(AddToTheseColorsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addToTheseColors != null) {
      data[addToTheseColorsJsonKey] =
          addToTheseColors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
