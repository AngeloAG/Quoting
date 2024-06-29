import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_quote_work.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iquotes_datasource.dart';
import 'package:fpdart/fpdart.dart';

class QuotesRepository implements IQuotesRepository {
  final IQuotesDataSource iQuotesDataSource;

  QuotesRepository(this.iQuotesDataSource);

  @override
  TaskEither<Failure, Stream<List<Quote>>> getAllQuotes() {
    return iQuotesDataSource
        .getAllQuotes()
        .map((quotesModelsStream) => quotesModelsStream.map((quoteModels) {
              return quoteModels.map((quoteModel) {
                var author =
                    Author(id: quoteModel.authorId, name: quoteModel.author);
                var label =
                    Label(id: quoteModel.labelId, label: quoteModel.label);
                var source =
                    Source(id: quoteModel.sourceId, source: quoteModel.source);

                return Quote(
                    id: quoteModel.id,
                    author: author,
                    label: label,
                    source: source,
                    content: quoteModel.content,
                    details: quoteModel.details);
              }).toList();
            }));
  }

  @override
  TaskEither<Failure, Unit> removeQuoteById(String quoteId) {
    return iQuotesDataSource.removeQuoteById(quoteId);
  }

  @override
  TaskEither<Failure, Unit> uploadQuote(CreateQuoteWork createQuoteWork) {
    throw UnimplementedError();
  }
}
