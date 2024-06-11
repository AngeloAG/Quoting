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
  void initState() {
    context.read<LabelBloc>().add(LabelLoadEvent());
    super.initState();
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
                child: BlocConsumer<LabelBloc, LabelState>(
              listener: (context, state) {
                if (state is LabelLoadFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                }
                if (state is LabelUploadFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                }
              },
              builder: (context, state) {
                if (state is LabelLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is LabelLoadSuccess) {
                  return ListView.builder(
                    itemCount: state.labels.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(state.labels[index].label),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: const Icon(Icons.edit_note_rounded),
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_sharp),
                                onPressed: () {},
                              ),
                            ]),
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
                    controller: newLabelController,
                    decoration:
                        const InputDecoration(hintText: 'Add new label'),
                  ),
                ),
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      context.read<LabelBloc>().add(LabelUploadEvent(
                          labelContent: newLabelController.text));
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
