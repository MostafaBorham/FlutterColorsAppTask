import 'package:colors_app/core/app_resources/app_strings.dart';

abstract class Failure {
  String get getFailureMessage;
}
////////////////////////////////////////////////////////////

class NoAutoCompleteSuggestionsFailure extends Failure {
  @override
  // TODO: implement getFailureMessage
  String get getFailureMessage => throw UnimplementedError();
}

class FailGetErrorColorsFailure extends Failure {
  @override
  // TODO: implement getFailureMessage
  String get getFailureMessage => FAIL_GET_ERROR_COLORS_FAILURE_MESSAGE;
}

class NoDefaultColorFailure extends Failure {
  @override
  // TODO: implement getFailureMessage
  String get getFailureMessage => throw UnimplementedError();
}
