import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/presentation/blocs/quotes/quote_bloc.dart';
import 'package:flutter_files/presentation/shared/quote_card.dart';

class ViewQuote extends StatefulWidget {
  const ViewQuote({super.key});

  @override
  State<ViewQuote> createState() => _ViewQuoteState();
}

class _ViewQuoteState extends State<ViewQuote> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Beamer.of(context).beamBack();
      },
      child: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('View Quote'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.beamToNamed(
                        '/quotes/${state.quotes[state.currentQuoteIndex].id}/edit',
                        data: state.quotes[state.currentQuoteIndex]);
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    QuoteCard(quote: state.quotes[state.currentQuoteIndex]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
