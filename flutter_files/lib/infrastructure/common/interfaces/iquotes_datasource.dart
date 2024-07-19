import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_quote_work.dart';
import 'package:flutter_files/domain/works/update_quote_work.dart';
import 'package:flutter_files/infrastructure/common/models/quote_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IQuotesDataSource {
  TaskEither<Failure, Unit> uploadQuote(CreateQuoteWork createQuoteWork);

  TaskEither<Failure, Unit> removeQuoteById(String id);

  TaskEither<Failure, List<QuoteModel>> getAllQuotes();

  TaskEither<Failure, List<QuoteModel>> getPaginatedQuotes(
      int amountOfQuotes, int offset);

  TaskEither<Failure, Unit> updateQuote(UpdateQuoteWork updateQuoteWork);

  TaskEither<Failure, List<QuoteModel>> searchQuotes(String query);
}
