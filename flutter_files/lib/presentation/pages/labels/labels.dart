import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/init_dependencies.dart';
import 'package:flutter_files/presentation/blocs/label/label_bloc.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';
import 'package:flutter_files/presentation/shared/utilities.dart';

class LabelsPage extends StatefulWidget {
  const LabelsPage({super.key});

  @override
  State<LabelsPage> createState() => _LabelsPageState();
}

class _LabelsPageState extends State<LabelsPage> {
  final newLabelController = TextEditingController();
  late LabelBloc _labelBloc;
  List<Label> labels = [];

  @override
  void dispose() {
    newLabelController.dispose();
    _labelBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _labelBloc = serviceLocator<LabelBloc>();
    _labelBloc.add(LabelLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labels'),
      ),
      endDrawer: const CustomDrawer(),
      body: BlocProvider(
        create: (context) => _labelBloc,
        child: Padding(
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
                  if (state.status == LabelStatus.failure) {
                    showSnackBar(state.failureMessage, context);
                  }
                  if (state.status == LabelStatus.success ||
                      state.status == LabelStatus.loaded) {
                    labels = state.labels;
                  }
                },
                builder: (context, state) {
                  if (state.status == LabelStatus.loading && labels.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (labels.isNotEmpty) {
                    return ListView.builder(
                      itemCount: labels.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(labels[index].label),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit_note_rounded),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_sharp),
                                      onPressed: () {
                                        context.read<LabelBloc>().add(
                                            LabelRemoveEvent(
                                                label: labels[index]));
                                      },
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
                        if (newLabelController.text.isNotEmpty) {
                          context.read<LabelBloc>().add(LabelUploadEvent(
                              labelContent: newLabelController.text));
                          FocusManager.instance.primaryFocus?.unfocus();
                          newLabelController.clear();
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
      ),
    );
  }
}
