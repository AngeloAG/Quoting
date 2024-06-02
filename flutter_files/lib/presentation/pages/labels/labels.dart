import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/presentation/blocs/label/label_bloc.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';

class LabelsPage extends StatefulWidget {
  const LabelsPage({super.key});

  @override
  State<LabelsPage> createState() => _LabelsPageState();
}

class _LabelsPageState extends State<LabelsPage> {
  final newLabelController = TextEditingController();

  @override
  void dispose() {
    newLabelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labels'),
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
                child: ListView(
              children: const [Text('List of labels')],
            )),
            SizedBox(
              height: 100,
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: newLabelController,
                      decoration:
                          const InputDecoration(hintText: 'Add new label'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<LabelBloc>().add(LabelUploadEvent(
                          labelContent: newLabelController.text));
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
