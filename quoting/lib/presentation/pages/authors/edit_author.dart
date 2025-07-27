import 'package:flutter/material.dart';
import 'package:quoting/domain/models/author.dart';

class EditAuthorDialog extends StatefulWidget {
  final void Function(Author authorUpdate) onSubmit;
  final Author originalAuthor;

  const EditAuthorDialog({
    super.key,
    required this.onSubmit,
    required this.originalAuthor,
  });

  @override
  State<EditAuthorDialog> createState() => _EditAuthorDialogState();
}

class _EditAuthorDialogState extends State<EditAuthorDialog> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.originalAuthor.name;
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
      title: const Text('Edit author'),
      content: TextFormField(
        controller: controller,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Update'),
          onPressed: () {
            widget.onSubmit(Author(
                id: widget.originalAuthor.id, name: controller.text.trim()));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
