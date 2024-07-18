import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';

class ViewQuote extends StatelessWidget {
  final Quote quote;

  const ViewQuote({super.key, required this.quote});

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.beamToNamed('/quotes/${quote.id}/edit',
                              data: quote);
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                Text(quote.content),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(quote.author.toNullable()?.name ?? ''),
                    Text(quote.label.toNullable()?.label ?? ''),
                  ],
                ),
                Text(quote.source.toNullable()?.source ?? ''),
                Text(quote.details),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
