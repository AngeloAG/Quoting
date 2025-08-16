import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:quoting/presentation/blocs/source/source_bloc.dart';
import 'package:quoting/presentation/pages/sources/edit_source.dart';

class SourceSmallCard extends StatelessWidget {
  final Source source;

  const SourceSmallCard({
    super.key,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          title: Text(source.source),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
              icon: const Icon(Icons.edit_note_rounded),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext _) {
                      return EditSourceDialog(
                          onSubmit: (Source sourceUpdate) => context
                              .read<SourceBloc>()
                              .add(SourceUpdateEvent(source: sourceUpdate)),
                          originalSource: source);
                    });
              },
            ),
            const SizedBox(
              width: 15.0,
            ),
            IconButton(
              icon: const Icon(Icons.delete_sharp),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Source'),
                    content: const Text(
                        'Are you sure you want to delete this source? This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  context
                      .read<SourceBloc>()
                      .add(SourceRemoveEvent(source: source));
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
