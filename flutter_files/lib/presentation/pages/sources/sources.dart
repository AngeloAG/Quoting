import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/presentation/blocs/source/source_bloc.dart';
import 'package:flutter_files/presentation/pages/sources/edit_source.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';
import 'package:flutter_files/presentation/shared/utilities.dart';

class SourcesPage extends StatefulWidget {
  const SourcesPage({super.key});

  @override
  State<SourcesPage> createState() => _SourcesPageState();
}

class _SourcesPageState extends State<SourcesPage> {
  final newSourceController = TextEditingController();
  List<Source> sources = [];

  @override
  void dispose() {
    newSourceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<SourceBloc>().add(SourceLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sources'),
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
                child: BlocConsumer<SourceBloc, SourceState>(
              listener: (context, state) {
                if (state.status == SourceStatus.failure) {
                  showSnackBar(state.failureMessage, context);
                }
                if (state.status == SourceStatus.success ||
                    state.status == SourceStatus.loaded) {
                  sources = state.sources;
                }
              },
              builder: (context, state) {
                if (state.status == SourceStatus.loading && sources.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (sources.isNotEmpty) {
                  return ListView.builder(
                    itemCount: sources.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(sources[index].source),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: const Icon(Icons.edit_note_rounded),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext _) {
                                        return EditSourceDialog(
                                            onSubmit: (Source sourceUpdate) =>
                                                context.read<SourceBloc>().add(
                                                    SourceUpdateEvent(
                                                        source: sourceUpdate)),
                                            originalSource: sources[index]);
                                      });
                                },
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_sharp),
                                onPressed: () {
                                  context.read<SourceBloc>().add(
                                      SourceRemoveEvent(
                                          source: sources[index]));
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
                    controller: newSourceController,
                    decoration:
                        const InputDecoration(hintText: 'Add new label'),
                  ),
                ),
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      if (newSourceController.text.isNotEmpty) {
                        context.read<SourceBloc>().add(SourceUploadEvent(
                            sourceContent: newSourceController.text.trim()));
                        FocusManager.instance.primaryFocus?.unfocus();
                        newSourceController.clear();
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
    );
  }
}
