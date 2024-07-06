import 'package:fpdart/fpdart.dart';

class UpdateQuoteWork {
  final String id;
  final Option<String> authorId;
  final Option<String> labelId;
  final Option<String> sourceId;
  final String details;
  final String content;

  UpdateQuoteWork({
    required this.id,
    required this.authorId,
    required this.labelId,
    required this.sourceId,
    required this.details,
    required this.content,
  });
}
