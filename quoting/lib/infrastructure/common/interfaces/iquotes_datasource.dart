import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/works/create_quote_work.dart';
import 'package:quoting/domain/works/update_quote_work.dart';
import 'package:quoting/infrastructure/common/models/quote_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IQuotesDataSource {
  TaskEither<Failure, Unit> uploadQuote(CreateQuoteWork createQuoteWork);

  TaskEither<Failure, Unit> removeQuoteById(String id);

  TaskEither<Failure, List<QuoteModel>> getAllQuotes();

  TaskEither<Failure, List<QuoteModel>> getPaginatedQuotes(
      int amountOfQuotes, int offset);

  TaskEither<Failure, Unit> updateQuote(UpdateQuoteWork updateQuoteWork);

  TaskEither<Failure, List<QuoteModel>> searchQuotes(String query);

  TaskEither<Failure, List<QuoteModel>> getFilteredQuotes({
    int? authorId,
    int? labelId,
    int? sourceId,
  });
}
