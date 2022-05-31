const String colorJsonKey = 'color';
const String errorJsonKey = 'error';
const String errorMessageJsonKey = 'errorMessage';

class AsyncValidationColorsModel {
  String? color;
  bool? error;
  String? errorMessage;

  AsyncValidationColorsModel({this.color, this.error, this.errorMessage});

  AsyncValidationColorsModel.fromJson(Map<String, dynamic> json) {
    color = json[colorJsonKey];
    error = json[errorJsonKey];
    errorMessage = json[errorMessageJsonKey];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[colorJsonKey] = color;
    data[errorJsonKey] = error;
    data[errorMessageJsonKey] = errorMessage;
    return data;
  }
}
