import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoting/presentation/blocs/quotes/quote_bloc.dart';
import 'package:quoting/presentation/shared/quote_card.dart';
import 'package:quoting/presentation/shared/utilities.dart';

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
      onPopInvokedWithResult: (didPop, result) {
        Beamer.of(context).beamBack();
      },
      child: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state.quotes.isEmpty ||
              state.currentQuoteIndex < 0 ||
              state.currentQuoteIndex >= state.quotes.length) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('View Quote'),
              ),
              body: const Center(
                child: Text('Quote not found.'),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('View Quote'),
              actions: [
                BlocListener<QuoteBloc, QuoteState>(
                  listener: (context, state) {
                    if (state.status == QuoteStatus.deleteSuccess) {
                      Beamer.of(context).beamBack();
                    } else if (state.status == QuoteStatus.deleteFailure) {
                      showSnackBar(
                        'Failed to delete quote: ${state.failureMessage}',
                        context,
                      );
                    }
                  },
                  child: IconButton(
                    onPressed: () {
                      context.read<QuoteBloc>().add(
                            QuoteRemoveEvent(
                              quote: state.quotes[state.currentQuoteIndex],
                            ),
                          );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
                const SizedBox(width: 12.0),
                IconButton(
                  onPressed: () {
                    context.beamToNamed(
                        '/quotes/${state.quotes[state.currentQuoteIndex].id}/edit',
                        data: state.quotes[state.currentQuoteIndex]);
                  },
                  icon: const Icon(Icons.edit),
                ),
                const SizedBox(width: 12.0),
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
