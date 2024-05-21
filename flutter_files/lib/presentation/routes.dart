import 'package:beamer/beamer.dart';
import 'package:flutter_files/presentation/pages/home/home.dart';
import 'package:flutter_files/presentation/pages/login/login.dart';
import 'package:flutter_files/presentation/pages/settings/settings.dart';

var routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '': (context, state, data) => const Home(initialIndex: 0),
      'quotes': (context, state, data) => const Home(initialIndex: 0),
      'login': (context, state, data) => const LoginPage(),
      'authors': (context, state, data) => const Home(initialIndex: 1),
      'new_quote': (context, state, data) => const Home(initialIndex: 2),
      'settings': (context, state, data) => const SettingsPage(),
      'labels': (context, state, data) => const Home(initialIndex: 3),
      'sources': (context, state, data) => const Home(initialIndex: 4)
    },
  ),
);
