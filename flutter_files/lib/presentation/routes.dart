import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/presentation/blocs/backup_restore/backup_restore_bloc.dart';
import 'package:flutter_files/presentation/pages/edit_quote/edit_quote.dart';
import 'package:flutter_files/presentation/pages/home/home.dart';
import 'package:flutter_files/presentation/pages/login/login.dart';
import 'package:flutter_files/presentation/pages/settings/settings.dart';
import 'package:flutter_files/presentation/pages/view_quote/view_quote.dart';

var routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/': (context, state, data) => const Home(initialIndex: 0),
      'quotes/:quoteId': (context, state, data) => const ViewQuote(),
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
      'login': (context, state, data) => const LoginPage(),
      'settings': (context, state, data) => BlocProvider(
            create: (_) => BackupRestoreBloc(),
            child: const SettingsPage(),
          ),
    },
  ).call,
);
