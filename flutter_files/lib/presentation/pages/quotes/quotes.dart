import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/presentation/blocs/quotes/quote_bloc.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';
import 'package:flutter_files/presentation/shared/quote_card.dart';
import 'package:flutter_files/presentation/shared/utilities.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  final _scrollController = ScrollController();
  final SearchController _searchController = SearchController();
  Timer? _debounce;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels &&
          !context.read<QuoteBloc>().isLastPage) {
        context.read<QuoteBloc>().add(QuoteLoadEvent());
      }
    });

    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          context
              .read<QuoteBloc>()
              .add(QuoteSearchEvent(query: _searchController.text));
        });
      }
    });

    context.read<QuoteBloc>().add(QuoteLoadEvent());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        actions: const [
          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) =>
          //               DriftDbViewer(serviceLocator<DriftDB>())));
          //     },
          //     icon: const Icon(Icons.door_back_door))
        ],
      ),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchAnchor(
              searchController: _searchController,
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                );
              },
              viewBuilder: (suggestions) {
                return BlocBuilder<QuoteBloc, QuoteState>(
                  builder: (context, state) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 8.0, right: 8.0),
                      itemCount: state.searchedQuotes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<QuoteBloc>()
                                .add(QuoteSelectEvent(index: index));
                            context.beamToNamed(
                                '/quotes/${state.quotes[index].id}');
                          },
                          child: QuoteCard(quote: state.searchedQuotes[index]),
                        );
                      },
                    );
                  },
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
                },
                builder: (context, state) {
                  if (state.status == QuoteStatus.loading &&
                      state.quotes.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.quotes.isNotEmpty) {
                    return Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context.read<QuoteBloc>().add(QuoteReloadEvent());
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: state.quotes.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<QuoteBloc>()
                                        .add(QuoteSelectEvent(index: index));
                                    context.beamToNamed(
                                        '/quotes/${state.quotes[index].id}');
                                  },
                                  child: QuoteCard(quote: state.quotes[index]),
                                );
                              },
                            ),
                          ),
                        ),
                        if (state.status == QuoteStatus.loading &&
                            !context.read<QuoteBloc>().isLastPage)
                          const SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    );
                  }
                  // Show a refreshable empty state when there are no quotes and not loading
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<QuoteBloc>().add(QuoteReloadEvent());
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 200),
                        Center(
                          child: Text(
                            'No quotes found. Pull down to refresh.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
