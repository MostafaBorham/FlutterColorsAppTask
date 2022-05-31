import 'package:colors_app/features/colors/data/models/personal_favourite_colors.dart';
import 'package:colors_app/features/colors/data/models/async_validation_colors.dart';

const String asyncValidationColorsJsonKey = 'asyncValidationColors';
const String autoSuggestionsColorsJsonKey = 'autoSuggestionsColors';
const String personalFavouriteColorsJsonKey = 'personalFavouriteColors';

class GroupOfColorsModel {
  List<AsyncValidationColorsModel>? asyncValidationColors;
  List<String>? autoSuggestionsColors;
  PersonalFavoriteColorsModel? personalFavoriteColors;

  GroupOfColorsModel(
      {this.asyncValidationColors,
      this.autoSuggestionsColors,
      this.personalFavoriteColors});

  GroupOfColorsModel.fromJson(Map<String, dynamic> json) {
    if (json[asyncValidationColorsJsonKey] != null) {
      asyncValidationColors = <AsyncValidationColorsModel>[];
      json[asyncValidationColorsJsonKey].forEach((v) {
        asyncValidationColors!.add(AsyncValidationColorsModel.fromJson(v));
      });
    }
    autoSuggestionsColors = json[autoSuggestionsColorsJsonKey].cast<String>();
    personalFavoriteColors = json[personalFavouriteColorsJsonKey] != null
        ? PersonalFavoriteColorsModel.fromJson(json[personalFavouriteColorsJsonKey])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (asyncValidationColors != null) {
      data[asyncValidationColorsJsonKey] =
          asyncValidationColors!.map((v) => v.toJson()).toList();
    }
    data[autoSuggestionsColorsJsonKey] = autoSuggestionsColors;
    if (personalFavoriteColors != null) {
      data[personalFavouriteColorsJsonKey] = personalFavoriteColors!.toJson();
    }
    return data;
  }
}
