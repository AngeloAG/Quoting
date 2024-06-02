import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/models/source.dart';

class CreateQuoteWork {
  final Author author;
  final Label label;
  final Source source;
  final String details;
  final String content;

  CreateQuoteWork({
    required this.author,
    required this.label,
    required this.source,
    required this.details,
    required this.content,
  });
}
