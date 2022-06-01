import 'package:colors_app/core/dependency_injection/di.dart' as di;
import 'package:colors_app/features/colors/presentation/pages/user_colors_form/main_page.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_bloc.dart';
import 'package:colors_app/features/colors/presentation/state_management/bloc/colors/colors_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.initAppDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => di.instance<ColorsBloc>()
              ..add(GetAutoCompleteSuggestionsEvent())
              ..add(GetDefaultColorEvent())
              ..add(GetAllErrorColors())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserColorsForm(),
      ),
    );
  }
}
