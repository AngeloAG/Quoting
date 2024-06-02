import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/domain/works/create_quote_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IQuotesRepository {
  Future<Either<String, dynamic>> removeQuoteById(String quoteId);

  Future<Either<String, Quote>> uploadQuote(CreateQuoteWork createQuoteWork);

  Future<Either<String, List<Quote>>> getAllQuotes();
}
