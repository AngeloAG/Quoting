import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/domain/models/label.dart';

class EditLabelDialog extends StatefulWidget {
  final void Function(Label labelUpdate) onSubmit;
  final Label originalLabel;

  const EditLabelDialog({
    super.key,
    required this.onSubmit,
    required this.originalLabel,
  });

  @override
  State<EditLabelDialog> createState() => _EditLabelDialogState();
}

class _EditLabelDialogState extends State<EditLabelDialog> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.originalLabel.label;
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
      title: const Text('Edit label'),
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
            widget.onSubmit(Label(
                id: widget.originalLabel.id, label: controller.text.trim()));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
