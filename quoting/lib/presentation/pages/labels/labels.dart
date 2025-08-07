import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoting/presentation/blocs/label/label_bloc.dart';
import 'package:quoting/presentation/pages/labels/label_small_card.dart';
import 'package:quoting/presentation/shared/drawer.dart';
import 'package:quoting/presentation/shared/utilities.dart';

class LabelsPage extends StatefulWidget {
  const LabelsPage({super.key});

  @override
  State<LabelsPage> createState() => _LabelsPageState();
}

class _LabelsPageState extends State<LabelsPage> {
  final newLabelController = TextEditingController();
  final _searchController = SearchController();
  final _searchFocusNode = FocusNode();
  Timer? _debounce;

  @override
  void dispose() {
    newLabelController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty && _searchController.text != "") {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          context
              .read<LabelBloc>()
              .add(LabelSearchEvent(query: _searchController.text));
        });
      }
    });

    if (context.read<LabelBloc>().state.labels.isEmpty) {
      context.read<LabelBloc>().add(LabelLoadEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Labels'),
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
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
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
                          .read<LabelBloc>()
                          .add(LabelSearchEvent(query: value));
                      _searchController.text = value;
                    },
                    leading: const Icon(Icons.search),
                    autoFocus: false,
                  );
                },
                viewBuilder: (suggestions) {
                  return BlocBuilder<LabelBloc, LabelState>(
                    builder: (context, state) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 0.0),
                        itemCount: state.searchedLabels.length,
                        itemBuilder: (context, index) {
                          return LabelSmallCard(
                            label: state.searchedLabels[index],
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
                  child: BlocConsumer<LabelBloc, LabelState>(
                listener: (context, state) {
                  if (state.status == LabelStatus.failure) {
                    showSnackBar(state.failureMessage, context);
                  }
                },
                builder: (context, state) {
                  if (state.status == LabelStatus.loading &&
                      state.labels.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.labels.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.labels.length,
                      itemBuilder: (context, index) {
                        return LabelSmallCard(
                          label: state.labels[index],
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: newLabelController,
                      decoration: InputDecoration(
                        labelText: 'Add new label',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () {
                        if (newLabelController.text.isNotEmpty) {
                          context.read<LabelBloc>().add(LabelUploadEvent(
                              labelContent: newLabelController.text.trim()));
                          FocusManager.instance.primaryFocus?.unfocus();
                          newLabelController.clear();
                        }
                      },
                      icon: const Icon(Icons.add),
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
