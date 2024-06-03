import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/domain/works/create_quote_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IQuotesRepository {
  Future<Either<Failure, dynamic>> removeQuoteById(String quoteId);

  Future<Either<Failure, Quote>> uploadQuote(CreateQuoteWork createQuoteWork);

  Future<Either<Failure, List<Quote>>> getAllQuotes();
}
