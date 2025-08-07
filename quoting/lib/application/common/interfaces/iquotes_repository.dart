import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/quote.dart';
import 'package:quoting/domain/works/create_quote_work.dart';
import 'package:quoting/domain/works/update_quote_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IQuotesRepository {
  TaskEither<Failure, Unit> removeQuoteById(String quoteId);

  TaskEither<Failure, Unit> uploadQuote(CreateQuoteWork createQuoteWork);

  TaskEither<Failure, List<Quote>> getAllQuotes();

  TaskEither<Failure, List<Quote>> getPaginatedQuotes(
      int amountOfQuotes, int offset);

  TaskEither<Failure, Unit> updateQuote(UpdateQuoteWork updateQuoteWork);

  TaskEither<Failure, List<Quote>> searchQuotes(String query);

  TaskEither<Failure, List<Quote>> getFilteredQuotes({
    int? authorId,
    int? labelId,
    int? sourceId,
  });
}
