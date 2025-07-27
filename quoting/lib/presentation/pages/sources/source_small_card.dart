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
              onPressed: () {
                context
                    .read<SourceBloc>()
                    .add(SourceRemoveEvent(source: source));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
