import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/presentation/blocs/author/author_bloc.dart';
import 'package:flutter_files/presentation/pages/authors/author_small_card.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';
import 'package:flutter_files/presentation/shared/utilities.dart';

class AuthorsPage extends StatefulWidget {
  const AuthorsPage({super.key});

  @override
  State<AuthorsPage> createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  final newAuthorController = TextEditingController();
  final _searchController = SearchController();
  Timer? _debounce;

  @override
  void dispose() {
    newAuthorController.dispose();
    _searchController.dispose();
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
              .read<AuthorBloc>()
              .add(AuthorSearchEvent(query: _searchController.text));
        });
      }
    });

    context.read<AuthorBloc>().add(AuthorLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors'),
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
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                );
              },
              viewBuilder: (suggestions) {
                return BlocBuilder<AuthorBloc, AuthorState>(
                  builder: (context, state) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 0.0),
                      itemCount: state.searchedAuthors.length,
                      itemBuilder: (context, index) {
                        return AuthorSmallCard(
                            author: state.searchedAuthors[index]);
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
                child: BlocConsumer<AuthorBloc, AuthorState>(
              listener: (context, state) {
                if (state.status == AuthorStatus.failure) {
                  showSnackBar(state.failureMessage, context);
                }
              },
              builder: (context, state) {
                if (state.status == AuthorStatus.loading &&
                    state.authors.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.authors.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.authors.length,
                    itemBuilder: (context, index) {
                      return AuthorSmallCard(author: state.authors[index]);
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
                    controller: newAuthorController,
                    decoration:
                        const InputDecoration(hintText: 'Add new author'),
                  ),
                ),
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      if (newAuthorController.text.isNotEmpty) {
                        context.read<AuthorBloc>().add(AuthorUploadEvent(
                            authorName: newAuthorController.text.trim()));
                        FocusManager.instance.primaryFocus?.unfocus();
                        newAuthorController.clear();
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
    );
  }
}
