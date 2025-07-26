import 'package:quoting/domain/models/author.dart';
import 'package:quoting/domain/models/label.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:fpdart/fpdart.dart';

class Quote {
  final String id;
  final Option<Author> author;
  final Option<Label> label;
  final Option<Source> source;
  final String details;
  final String content;

  Quote({
    required this.id,
    required this.author,
    required this.label,
    required this.source,
    required this.details,
    required this.content,
  });
}
