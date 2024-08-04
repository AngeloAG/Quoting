import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/presentation/blocs/author/author_bloc.dart';
import 'package:flutter_files/presentation/pages/authors/edit_author.dart';

class AuthorSmallCard extends StatelessWidget {
  final Author author;

  const AuthorSmallCard({
    super.key,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          title: Text(author.name),
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
                            onSubmit: (Author authorUpdate) => context
                                .read<AuthorBloc>()
                                .add(AuthorUpdateEvent(author: authorUpdate)),
                            originalAuthor: author);
                      });
                },
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon: const Icon(Icons.delete_sharp),
                onPressed: () {
                  context
                      .read<AuthorBloc>()
                      .add(AuthorRemoveEvent(author: author));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
