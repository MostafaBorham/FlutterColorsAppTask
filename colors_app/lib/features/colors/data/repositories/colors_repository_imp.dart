import 'package:colors_app/core/error/failures.dart';
import 'package:colors_app/features/colors/data/data_sources/colors_local_data_source.dart';
import 'package:colors_app/features/colors/data/models/async_validation_colors.dart';
import 'package:colors_app/features/colors/domain/repositories/colors_repository.dart';
import 'package:dartz/dartz.dart';

class ColorsRepositoryImp extends ColorsRepository {
  final ColorsLocalDataSource colorsLocalDataSource;

  ColorsRepositoryImp({required this.colorsLocalDataSource});

  @override
  Future<Either<Failure, List<String>>> getAutoSuggestionsColors() async {
    Either<Failure, List<String>>? returnedValue;
    await colorsLocalDataSource.getColorsData().then((value) {
      returnedValue = Right(value.groupOfColors!.autoSuggestionsColors!);
    }).catchError((ex) {
      returnedValue = Left(NoAutoCompleteSuggestionsFailure());
    });
    return returnedValue!;
  }

  @override
  Future<Either<Failure, List<AsyncValidationColorsModel>>>
      getErrorColors() async {
    Either<Failure, List<AsyncValidationColorsModel>>? defaultValue;
    await colorsLocalDataSource.getColorsData().then((userColorModelInstance) {
      defaultValue =
          Right(userColorModelInstance.groupOfColors!.asyncValidationColors!);
    }).catchError((ex) {
      defaultValue = Left(FailGetErrorColorsFailure());
    });
    return defaultValue!;
  }

  @override
  Future<Either<Failure, String>> getDefaultColor() async {
    Either<Failure, String>? returnedValue;
    await colorsLocalDataSource.getColorsData().then((value) {
      returnedValue = Right(value.red!);
    }).catchError((ex) {
      returnedValue = Left(NoDefaultColorFailure());
    });
    return returnedValue!;
  }
}
