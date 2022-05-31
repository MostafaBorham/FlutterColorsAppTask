import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/colors_repository.dart';

class GetDefaultColorUseCase{
  final ColorsRepository _repository;


  GetDefaultColorUseCase(this._repository);

  Future<Either<Failure, String>> call(){
    return _repository.getDefaultColor();
  }
}