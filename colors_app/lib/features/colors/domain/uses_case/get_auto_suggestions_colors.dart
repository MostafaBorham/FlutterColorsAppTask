import 'package:colors_app/features/colors/domain/repositories/colors_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetAutoSuggestionsColorsUseCase{
  final ColorsRepository _repository;


  GetAutoSuggestionsColorsUseCase(this._repository);

  Future<Either<Failure,List<String>>> call() async{
    return await _repository.getAutoSuggestionsColors();
  }
}