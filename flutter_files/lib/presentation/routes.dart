import 'package:beamer/beamer.dart';
import 'package:flutter_files/presentation/pages/authors/authors.dart';
import 'package:flutter_files/presentation/pages/login/login.dart';
import 'package:flutter_files/presentation/pages/new_quote/new_quote.dart';
import 'package:flutter_files/presentation/pages/quotes/quotes.dart';
import 'package:flutter_files/presentation/pages/settings/settings.dart';
import 'package:flutter_files/presentation/pages/sources/sources.dart';

var beamerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '': (context, state, data) => const QuotesPage(),
      'login': (context, state, data) => const LoginPage(),
      'authors': (context, state, data) => const AuthorsPage(),
      'new_quote': (context, state, data) => const NewQuotePage(),
      'settings': (context, state, data) => const SettingsPage(),
      'sources': (context, state, data) => const SourcesPage()
    },
  ),
);
