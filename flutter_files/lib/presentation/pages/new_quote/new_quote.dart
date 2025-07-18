import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/presentation/blocs/author/author_bloc.dart';
import 'package:flutter_files/presentation/blocs/label/label_bloc.dart';
import 'package:flutter_files/presentation/blocs/quotes/quote_bloc.dart';
import 'package:flutter_files/presentation/blocs/source/source_bloc.dart';
import 'package:flutter_files/presentation/blocs/tabs/tabs_cubit.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';
import 'package:flutter_files/presentation/shared/utilities.dart';
import 'package:flutter_files/presentation/theme/pallete.dart';

class NewQuotePage extends StatefulWidget {
  const NewQuotePage({super.key});

  @override
  State<NewQuotePage> createState() => _NewQuotePageState();
}

class _NewQuotePageState extends State<NewQuotePage> {
  final _formKey = GlobalKey<FormState>();
  final _quoteContentController = TextEditingController();
  final _authorTextController = TextEditingController();
  final _authorFocusNode = FocusNode();
  final _labelTextController = TextEditingController();
  final _labelFocusNode = FocusNode();
  final _sourceTextController = TextEditingController();
  final _sourceFocusNode = FocusNode();
  final _detailsTextController = TextEditingController();
  Author? _author;
  Label? _label;
  Source? _source;

  @override
  void initState() {
    if (context.read<AuthorBloc>().state.authors.isEmpty) {
      context.read<AuthorBloc>().add(AuthorLoadEvent());
    }
    if (context.read<LabelBloc>().state.labels.isEmpty) {
      context.read<LabelBloc>().add(LabelLoadEvent());
    }
    if (context.read<SourceBloc>().state.sources.isEmpty) {
      context.read<SourceBloc>().add(SourceLoadEvent());
    }
    super.initState();
  }

  @override
  void dispose() {
    _quoteContentController.dispose();
    _authorTextController.dispose();
    _authorFocusNode.dispose();
    _labelTextController.dispose();
    _labelFocusNode.dispose();
    _sourceTextController.dispose();
    _sourceFocusNode.dispose();
    _detailsTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Quote'),
      ),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextField(
                controller: _quoteContentController,
                decoration: const InputDecoration(
                  label: Text('Quote text'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppPallete.borderColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppPallete.borderColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 40,
                maxLength: 3000,
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthorBloc, AuthorState>(
                listener: (context, state) {
                  if (state.status == AuthorStatus.failure) {
                    showSnackBar(state.failureMessage, context);
                  }
                },
                builder: (context, state) {
                  return RawAutocomplete<Author>(
                    textEditingController: _authorTextController,
                    focusNode: _authorFocusNode,
                    optionsBuilder: (textEditingValue) {
                      return state.authors.where((author) {
                        return author.name
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (Author selection) {
                      setState(() {
                        _author = selection;
                        _authorFocusNode.unfocus();
                      });
                    },
                    fieldViewBuilder: (context, textEditingController,
                        focusNode, onFieldSubmitted) {
                      return TextFormField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Author',
                        ),
                        focusNode: focusNode,
                        onFieldSubmitted: (value) {
                          onFieldSubmitted();
                        },
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final Author author = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(author);
                                  },
                                  child: ListTile(
                                    title: Text(author.name),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<LabelBloc, LabelState>(
                listener: (context, state) {
                  if (state.status == LabelStatus.failure) {
                    showSnackBar(state.failureMessage, context);
                  }
                },
                builder: (context, state) {
                  return RawAutocomplete<Label>(
                    textEditingController: _labelTextController,
                    focusNode: _labelFocusNode,
                    optionsBuilder: (textEditingValue) {
                      return state.labels.where((label) {
                        return label.label
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (Label selection) {
                      setState(() {
                        _label = selection;
                        _labelFocusNode.unfocus();
                      });
                    },
                    fieldViewBuilder: (context, textEditingController,
                        focusNode, onFieldSubmitted) {
                      return TextFormField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Label',
                        ),
                        focusNode: focusNode,
                        onFieldSubmitted: (value) {
                          onFieldSubmitted();
                        },
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final Label label = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(label);
                                  },
                                  child: ListTile(
                                    title: Text(label.label),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<SourceBloc, SourceState>(
                listener: (context, state) {
                  if (state.status == SourceStatus.failure) {
                    showSnackBar(state.failureMessage, context);
                  }
                },
                builder: (context, state) {
                  return RawAutocomplete<Source>(
                    textEditingController: _sourceTextController,
                    focusNode: _sourceFocusNode,
                    optionsBuilder: (textEditingValue) {
                      return state.sources.where((source) {
                        return source.source
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (Source selection) {
                      setState(() {
                        _source = selection;
                        _sourceFocusNode.unfocus();
                      });
                    },
                    fieldViewBuilder: (context, textEditingController,
                        focusNode, onFieldSubmitted) {
                      return TextFormField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Source',
                        ),
                        focusNode: focusNode,
                        onFieldSubmitted: (value) {
                          onFieldSubmitted();
                        },
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final Source source = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(source);
                                  },
                                  child: ListTile(
                                    title: Text(source.source),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _detailsTextController,
                decoration: const InputDecoration(
                  label: Text('Page, Paragraph, etc'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppPallete.borderColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppPallete.borderColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 1,
                maxLength: 300,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<QuoteBloc>().add(QuoteUploadEvent(
                      author: _author,
                      authorText: _authorTextController.text,
                      label: _label,
                      labelText: _labelTextController.text,
                      source: _source,
                      sourceText: _sourceTextController.text,
                      quoteText: _quoteContentController.text,
                      detailsText: _detailsTextController.text));
                  //context.read<QuoteBloc>().add(QuoteReloadEvent());
                  _authorTextController.clear();
                  _labelTextController.clear();
                  _sourceTextController.clear();
                  _quoteContentController.clear();
                  _detailsTextController.clear();
                  _authorFocusNode.unfocus();
                  _labelFocusNode.unfocus();
                  _sourceFocusNode.unfocus();
                  _author = null;
                  _label = null;
                  _source = null;
                  context.read<TabsCubit>().setTabIndex(0);
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
