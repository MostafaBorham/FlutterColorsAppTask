import 'package:colors_app/features/colors/data/models/async_validation_colors.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ColorsRepository{
  Future<Either<Failure,List<String>>> getAutoSuggestionsColors();
  Future<Either<Failure,String>> getDefaultColor();
  Future<Either<Failure,List<AsyncValidationColorsModel>>> getErrorColors();
}