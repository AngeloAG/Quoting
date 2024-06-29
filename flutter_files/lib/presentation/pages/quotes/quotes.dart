import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/presentation/blocs/label/label_bloc.dart';
import 'package:flutter_files/presentation/blocs/quotes/quote_bloc.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';
import 'package:flutter_files/presentation/shared/utilities.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<Quote> quotes = [];

  @override
  void initState() {
    context.read<QuoteBloc>().add(QuoteLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
      ),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.empty();
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: BlocConsumer<QuoteBloc, QuoteState>(
                listener: (context, state) {
                  if (state.status == QuoteStatus.failure) {
                    showSnackBar(state.failureMessage, context);
                  }
                  if (state.status == QuoteStatus.success ||
                      state.status == QuoteStatus.loaded) {
                    quotes = state.quotes;
                  }
                },
                builder: (context, state) {
                  if (state.status == QuoteStatus.loading && quotes.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (quotes.isNotEmpty) {
                    return ListView.builder(
                      itemCount: quotes.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(quotes[index].content),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit_note_rounded),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_sharp),
                                      onPressed: () {},
                                    ),
                                  ]),
                            ),
                            const Divider(
                              height: 5.0,
                              color: Colors.black12,
                            )
                          ],
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
