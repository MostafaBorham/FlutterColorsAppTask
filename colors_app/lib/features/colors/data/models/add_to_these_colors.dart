const String myFavouriteColorJsonKey = 'myFavouriteColor';
const String secondFavouriteColorJsonKey = 'secondFavouriteColor';

class AddToTheseColorsModel {
  String? myFavoriteColor;
  String? secondFavoriteColor;

  AddToTheseColorsModel({this.myFavoriteColor, this.secondFavoriteColor});

  AddToTheseColorsModel.fromJson(Map<String, dynamic> json) {
    myFavoriteColor = json[myFavouriteColorJsonKey];
    secondFavoriteColor = json[secondFavouriteColorJsonKey];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[myFavouriteColorJsonKey] = myFavoriteColor;
    data[secondFavouriteColorJsonKey] = secondFavoriteColor;
    return data;
  }
}
