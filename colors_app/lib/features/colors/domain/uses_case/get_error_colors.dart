import 'package:colors_app/features/colors/data/models/async_validation_colors.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/colors_repository.dart';

class GetErrorColorsUseCase{
  final ColorsRepository _repository;


  GetErrorColorsUseCase(this._repository);

  Future<Either<Failure, List<AsyncValidationColorsModel>>> call(){
    return _repository.getErrorColors();
  }
}