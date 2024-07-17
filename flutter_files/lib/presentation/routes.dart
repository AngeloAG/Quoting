import 'package:beamer/beamer.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/presentation/pages/edit_quote/edit_quote.dart';
import 'package:flutter_files/presentation/pages/home/home.dart';
import 'package:flutter_files/presentation/pages/login/login.dart';
import 'package:flutter_files/presentation/pages/settings/settings.dart';
import 'package:flutter_files/presentation/pages/view_quote/view_quote.dart';

var routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '': (context, state, data) => const Home(initialIndex: 0),
      'quotes': (context, state, data) => const Home(initialIndex: 0),
      'quotes/:quoteId/edit': (context, state, data) {
        final quote = (data as Quote);

        return EditQuote(
          id: state.pathParameters['quoteId']!,
          initialAuthor: quote.author.toNullable(),
          initialLabel: quote.label.toNullable(),
          initialSource: quote.source.toNullable(),
          initialQuoteContent: quote.content,
          initialDetails: quote.details,
        );
      },
      'quotes/:quoteId': (context, state, data) {
        final quote = (data as Quote);

        return ViewQuote(quote: quote);
      },
      'login': (context, state, data) => const LoginPage(),
      'authors': (context, state, data) => const Home(initialIndex: 1),
      'new_quote': (context, state, data) => const Home(initialIndex: 2),
      'settings': (context, state, data) => const SettingsPage(),
      'labels': (context, state, data) => const Home(initialIndex: 3),
      'sources': (context, state, data) => const Home(initialIndex: 4),
    },
  ),
);
