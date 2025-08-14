import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoting/presentation/blocs/author/author_bloc.dart';
import 'package:quoting/presentation/blocs/label/label_bloc.dart';
import 'package:quoting/presentation/blocs/quotes/quote_bloc.dart';
import 'package:quoting/presentation/blocs/source/source_bloc.dart';
import 'package:quoting/presentation/shared/drawer.dart';
import 'package:quoting/presentation/shared/quote_card.dart';
import 'package:quoting/presentation/shared/utilities.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  int? _selectedAuthorId;
  int? _selectedLabelId;
  int? _selectedSourceId;
  final _scrollController = ScrollController();
  final SearchController _searchController = SearchController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.atEdge &&
          position.pixels != 0 &&
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
    if (context.mounted) {
      if (context.read<AuthorBloc>().state.authors.isEmpty) {
        context.read<AuthorBloc>().add(AuthorLoadEvent());
      }
      if (context.read<LabelBloc>().state.labels.isEmpty) {
        context.read<LabelBloc>().add(LabelLoadEvent());
      }
      if (context.read<SourceBloc>().state.sources.isEmpty) {
        context.read<SourceBloc>().add(SourceLoadEvent());
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      if (!_searchFocusNode.hasFocus) {
                        controller.openView();
                      }
                    },
                    onSubmitted: (value) {
                      if (!controller.isOpen) {
                        controller.openView();
                      }
                      if (value.isEmpty) {
                        return;
                      }
                      // Trigger search with the submitted value
                      context
                          .read<QuoteBloc>()
                          .add(QuoteSearchEvent(query: value));
                      _searchController.text = value;
                    },
                    leading: const Icon(Icons.search),
                    autoFocus: false,
                  );
                },
                viewBuilder: (suggestions) {
                  return BlocBuilder<QuoteBloc, QuoteState>(
                    builder: (context, state) {
                      // Optionally, you could filter here if needed
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
                            child:
                                QuoteCard(quote: state.searchedQuotes[index]),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Author Dropdown
                  Expanded(
                    child: BlocBuilder<AuthorBloc, AuthorState>(
                      builder: (context, authorState) {
                        return DropdownButtonFormField<int>(
                          isExpanded: true,
                          value: _selectedAuthorId,
                          decoration: InputDecoration(
                            labelText: 'Author',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          items: [
                            const DropdownMenuItem<int>(
                              value: null,
                              child: Text('All Authors',
                                  overflow: TextOverflow.ellipsis, maxLines: 1),
                            ),
                            ...authorState.authors
                                .map((author) => DropdownMenuItem<int>(
                                      value: int.tryParse(author.id),
                                      child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 120),
                                        child: Text(
                                          author.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ))
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedAuthorId = value;
                            });
                            if (value == null &&
                                _selectedLabelId == null &&
                                _selectedSourceId == null) {
                              context.read<QuoteBloc>().add(QuoteReloadEvent());
                              return;
                            }
                            context.read<QuoteBloc>().add(QuoteFilterEvent(
                                  authorId: value,
                                  labelId: _selectedLabelId,
                                  sourceId: _selectedSourceId,
                                ));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Label Dropdown
                  Expanded(
                    child: BlocBuilder<LabelBloc, LabelState>(
                      builder: (context, labelState) {
                        return DropdownButtonFormField<int>(
                          isExpanded: true,
                          value: _selectedLabelId,
                          decoration: InputDecoration(
                            labelText: 'Label',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          items: [
                            const DropdownMenuItem<int>(
                              value: null,
                              child: Text('All Labels',
                                  overflow: TextOverflow.ellipsis, maxLines: 1),
                            ),
                            ...labelState.labels
                                .map((label) => DropdownMenuItem<int>(
                                      value: int.tryParse(label.id),
                                      child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 120),
                                        child: Text(
                                          label.label,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ))
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedLabelId = value;
                            });
                            if (value == null &&
                                _selectedAuthorId == null &&
                                _selectedSourceId == null) {
                              context.read<QuoteBloc>().add(QuoteReloadEvent());
                              return;
                            }
                            context.read<QuoteBloc>().add(QuoteFilterEvent(
                                  authorId: _selectedAuthorId,
                                  labelId: value,
                                  sourceId: _selectedSourceId,
                                ));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Source Dropdown
                  Expanded(
                    child: BlocBuilder<SourceBloc, SourceState>(
                      builder: (context, sourceState) {
                        return DropdownButtonFormField<int>(
                          isExpanded: true,
                          value: _selectedSourceId,
                          decoration: InputDecoration(
                            labelText: 'Source',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          items: [
                            const DropdownMenuItem<int>(
                              value: null,
                              child: Text('All Sources',
                                  overflow: TextOverflow.ellipsis, maxLines: 1),
                            ),
                            ...sourceState.sources
                                .map((source) => DropdownMenuItem<int>(
                                      value: int.tryParse(source.id),
                                      child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 120),
                                        child: Text(
                                          source.source,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ))
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedSourceId = value;
                            });
                            if (value == null &&
                                _selectedAuthorId == null &&
                                _selectedLabelId == null) {
                              context.read<QuoteBloc>().add(QuoteReloadEvent());
                              return;
                            }
                            context.read<QuoteBloc>().add(QuoteFilterEvent(
                                  authorId: _selectedAuthorId,
                                  labelId: _selectedLabelId,
                                  sourceId: value,
                                ));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
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
                                context
                                    .read<QuoteBloc>()
                                    .add(QuoteReloadEvent());
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
                                    child:
                                        QuoteCard(quote: state.quotes[index]),
                                  );
                                },
                              ),
                            ),
                          ),
                          // Only show spinner if loading AND there are already quotes
                          if (state.status == QuoteStatus.loading &&
                              state.quotes.isNotEmpty &&
                              !context.read<QuoteBloc>().isLastPage)
                            const SizedBox(
                              width: 100,
                              height: 50,
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
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
      ),
    );
  }
}
