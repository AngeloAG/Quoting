import 'package:flutter/material.dart';
import 'package:quoting/domain/models/source.dart';

class EditSourceDialog extends StatefulWidget {
  final void Function(Source sourceUpdate) onSubmit;
  final Source originalSource;

  const EditSourceDialog({
    super.key,
    required this.onSubmit,
    required this.originalSource,
  });

  @override
  State<EditSourceDialog> createState() => _EditSourceDialogState();
}

class _EditSourceDialogState extends State<EditSourceDialog> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.originalSource.source;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Source'),
      content: TextFormField(
        controller: controller,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
            foregroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: const Text('Update'),
          onPressed: () {
            widget.onSubmit(Source(
                id: widget.originalSource.id, source: controller.text.trim()));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
