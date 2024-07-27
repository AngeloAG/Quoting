import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/presentation/blocs/quotes/quote_bloc.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';

class ViewQuote extends StatelessWidget {
  const ViewQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Beamer.of(context).beamBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('View Quote'),
        ),
        endDrawer: const CustomDrawer(),
        body: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              context.beamToNamed(
                                  '/quotes/${state.quotes[state.currentQuoteIndex].id}/edit',
                                  data: state.quotes[state.currentQuoteIndex]);
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ),
                    Text(state.quotes[state.currentQuoteIndex].content),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.quotes[state.currentQuoteIndex].author
                                .toNullable()
                                ?.name ??
                            ''),
                        Text(state.quotes[state.currentQuoteIndex].label
                                .toNullable()
                                ?.label ??
                            ''),
                      ],
                    ),
                    Text(state.quotes[state.currentQuoteIndex].source
                            .toNullable()
                            ?.source ??
                        ''),
                    Text(state.quotes[state.currentQuoteIndex].details),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
