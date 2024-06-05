import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/quote_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IQuotesDataSource {
  Future<Either<Failure, QuoteModel>> uploadQuote(String authorId,
      String labelId, String sourceId, String details, String content);

  Future<Either<Failure, dynamic>> removeQuoteById(String id);

  Future<Either<Failure, List<QuoteModel>>> getAllQuotes();
}
