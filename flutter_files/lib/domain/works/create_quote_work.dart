import 'package:fpdart/fpdart.dart';

class CreateQuoteWork {
  final Option<String> authorId;
  final Option<String> labelId;
  final Option<String> sourceId;
  final String details;
  final String content;

  CreateQuoteWork({
    required this.authorId,
    required this.labelId,
    required this.sourceId,
    required this.details,
    required this.content,
  });
}
