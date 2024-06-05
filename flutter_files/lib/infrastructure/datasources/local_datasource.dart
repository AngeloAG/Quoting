import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iauthors_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/ilabels_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iquotes_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/isources_datasource.dart';
import 'package:flutter_files/infrastructure/common/models/author_model.dart';
import 'package:flutter_files/infrastructure/common/models/label_model.dart';
import 'package:flutter_files/infrastructure/common/models/quote_model.dart';
import 'package:flutter_files/infrastructure/common/models/source_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqlite_api.dart';

class LocalDataSource
    implements
        IQuotesDataSource,
        IAuthorsDataSource,
        ILabelsDataSource,
        ISourcesDataSource {
  final Database db;

  LocalDataSource(this.db);

  @override
  Future<Either<Failure, List<AuthorModel>>> getAllAuthors() {
    // TODO: implement getAllAuthors
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<LabelModel>>> getAllLabels() {
    // TODO: implement getAllLabels
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getAllQuotes() {
    // TODO: implement getAllQuotes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<SourceModel>>> getAllSources() {
    // TODO: implement getAllSources
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> removeAuthorById(String id) {
    // TODO: implement removeAuthorById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> removeLabelById(String id) {
    // TODO: implement removeLabelById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> removeQuoteById(String id) {
    // TODO: implement removeQuoteById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> removeSourceById(String id) {
    // TODO: implement removeSourceById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthorModel>> uploadAuthor(String author) {
    // TODO: implement uploadAuthor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LabelModel>> uploadLabel(String label) {
    // TODO: implement uploadLabel
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, QuoteModel>> uploadQuote(String authorId,
      String labelId, String sourceId, String details, String content) {
    // TODO: implement uploadQuote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SourceModel>> uploadSource(String source) {
    // TODO: implement uploadSource
    throw UnimplementedError();
  }
}
