import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/quote_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IQuotesDataSource {
  TaskEither<Failure, QuoteModel> uploadQuote(String authorId, String labelId,
      String sourceId, String details, String content);

  TaskEither<Failure, Unit> removeQuoteById(String id);

  TaskEither<Failure, List<QuoteModel>> getAllQuotes();
}
