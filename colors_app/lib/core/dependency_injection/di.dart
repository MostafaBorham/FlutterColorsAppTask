
import 'package:colors_app/features/colors/data/data_sources/colors_local_data_source.dart';
import 'package:colors_app/features/colors/data/repositories/colors_repository_imp.dart';
import 'package:colors_app/features/colors/domain/repositories/colors_repository.dart';
import 'package:colors_app/features/colors/domain/uses_case/get_auto_suggestions_colors.dart';
import 'package:colors_app/features/colors/domain/uses_case/get_default_color.dart';
import 'package:colors_app/features/colors/domain/uses_case/get_error_colors.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_bloc.dart';
import 'package:get_it/get_it.dart';

final instance=GetIt.instance;

initAppDependencies() async{
  //Data Sources
  instance.registerLazySingleton<ColorsLocalDataSource>(() => ColorsLocalDataSourceJsonFile());
  //Bloc
  instance.registerFactory<ColorsBloc>(() => ColorsBloc(errorColorsUseCase: instance(),autoSuggestionsColorsUseCase: instance(),defaultColorUseCase: instance()));
  //repositories
  instance.registerLazySingleton<ColorsRepository>(() => ColorsRepositoryImp(colorsLocalDataSource: instance()));
  //Uses Cases
  instance.registerLazySingleton<GetErrorColorsUseCase>(() => GetErrorColorsUseCase(instance()));
  instance.registerLazySingleton<GetAutoSuggestionsColorsUseCase>(() => GetAutoSuggestionsColorsUseCase(instance()));
  instance.registerLazySingleton<GetDefaultColorUseCase>(() => GetDefaultColorUseCase(instance()));
}