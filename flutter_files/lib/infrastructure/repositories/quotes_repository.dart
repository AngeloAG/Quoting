import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/domain/works/create_quote_work.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iquotes_datasource.dart';
import 'package:fpdart/fpdart.dart';

class QuotesRepository implements IQuotesRepository {
  final IQuotesDataSource iQuotesDataSource;

  QuotesRepository(this.iQuotesDataSource);

  @override
  TaskEither<Failure, List<Quote>> getAllQuotes() {
    // TODO: implement getAllQuotes
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, dynamic> removeQuoteById(String quoteId) {
    // TODO: implement removeQuoteById
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Quote> uploadQuote(CreateQuoteWork createQuoteWork) {
    // TODO: implement uploadQuote
    throw UnimplementedError();
  }
}
