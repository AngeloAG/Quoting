import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/presentation/routes.dart';

void main() {
  Beamer.setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
      title: 'Quoting',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 98, 183, 58)),
        useMaterial3: true,
      ),
    );
  }
}
