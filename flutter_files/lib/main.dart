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
      routeInformationParser: BeamerParser(),
      routerDelegate: beamerDelegate,
      title: 'Quoting',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
