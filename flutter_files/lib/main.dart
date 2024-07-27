import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/init_dependencies.dart';
import 'package:flutter_files/presentation/blocs/author/author_bloc.dart';
import 'package:flutter_files/presentation/blocs/label/label_bloc.dart';
import 'package:flutter_files/presentation/blocs/quotes/quote_bloc.dart';
import 'package:flutter_files/presentation/blocs/source/source_bloc.dart';
import 'package:flutter_files/presentation/blocs/tabs/tabs_cubit.dart';
import 'package:flutter_files/presentation/routes.dart';

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
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        title: 'Quoting',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 98, 183, 58)),
          useMaterial3: true,
        ),
      ),
    );
  }
}
