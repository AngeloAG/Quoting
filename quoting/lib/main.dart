import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoting/init_dependencies.dart';
import 'package:quoting/presentation/blocs/author/author_bloc.dart';
import 'package:quoting/presentation/blocs/label/label_bloc.dart';
import 'package:quoting/presentation/blocs/quotes/quote_bloc.dart';
import 'package:quoting/presentation/blocs/source/source_bloc.dart';
import 'package:quoting/presentation/blocs/tabs/tabs_cubit.dart';
import 'package:quoting/presentation/blocs/theme/cubit/theme_cubit.dart';
import 'package:quoting/presentation/routes.dart';
import 'package:quoting/presentation/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  Beamer.setPathUrlStrategy();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LabelBloc>(create: (_) => serviceLocator<LabelBloc>()),
        BlocProvider<AuthorBloc>(create: (_) => serviceLocator<AuthorBloc>()),
        BlocProvider<SourceBloc>(create: (_) => serviceLocator<SourceBloc>()),
        BlocProvider<QuoteBloc>(create: (_) => serviceLocator<QuoteBloc>()),
        BlocProvider<TabsCubit>(create: (_) => serviceLocator<TabsCubit>()),
        BlocProvider<ThemeCubit>(create: (_) => serviceLocator<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationParser: BeamerParser(),
            routerDelegate: routerDelegate,
            title: 'Quoting',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
