import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/presentation/blocs/author/author_bloc.dart';
import 'package:flutter_files/presentation/pages/authors/edit_author.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';
import 'package:flutter_files/presentation/shared/utilities.dart';

class AuthorsPage extends StatefulWidget {
  const AuthorsPage({super.key});

  @override
  State<AuthorsPage> createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  final newAuthorController = TextEditingController();

  @override
  void dispose() {
    newAuthorController.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
                      return Column(
                        children: [
                          ListTile(
                            title: Text(state.authors[index].name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit_note_rounded),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext _) {
                                          return EditAuthorDialog(
                                              onSubmit: (Author authorUpdate) =>
                                                  context
                                                      .read<AuthorBloc>()
                                                      .add(AuthorUpdateEvent(
                                                          author:
                                                              authorUpdate)),
                                              originalAuthor:
                                                  state.authors[index]);
                                        });
                                  },
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_sharp),
                                  onPressed: () {
                                    context.read<AuthorBloc>().add(
                                        AuthorRemoveEvent(
                                            author: state.authors[index]));
                                  },
                                ),
                              ],
                            ),
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
