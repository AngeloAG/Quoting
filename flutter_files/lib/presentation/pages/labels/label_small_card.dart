import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/presentation/blocs/label/label_bloc.dart';
import 'package:flutter_files/presentation/pages/labels/edit_label.dart';

class LabelSmallCard extends StatelessWidget {
  final Label label;

  const LabelSmallCard({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          title: Text(label.label),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
              icon: const Icon(Icons.edit_note_rounded),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext _) {
                      return EditLabelDialog(
                          onSubmit: (Label labelUpdate) => context
                              .read<LabelBloc>()
                              .add(LabelUpdateEvent(label: labelUpdate)),
                          originalLabel: label);
                    });
              },
            ),
            const SizedBox(
              width: 15.0,
            ),
            IconButton(
              icon: const Icon(Icons.delete_sharp),
              onPressed: () {
                context.read<LabelBloc>().add(LabelRemoveEvent(label: label));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
