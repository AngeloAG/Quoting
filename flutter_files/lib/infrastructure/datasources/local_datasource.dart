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
  TaskEither<Failure, List<AuthorModel>> getAllAuthors() {
    return TaskEither.tryCatch(
      () => db.query('authors'),
      (error, stackTrace) => Failure(
          message:
              'Failed to get authors from DB with error: ${error.toString()}'),
    ).flatMap((authors) => Either.tryCatch(
          () => authors
              .map((authorMap) => AuthorModel.fromMap(authorMap))
              .toList(),
          (o, s) => Failure(
              message: 'Failed to parse authors with error ${o.toString()}'),
        ).toTaskEither());
  }

  @override
  TaskEither<Failure, List<LabelModel>> getAllLabels() {
    return TaskEither.tryCatch(
      () => db.query('label'),
      (error, stackTrace) => Failure(message: 'Failed to get labels from DB'),
    ).flatMap((labels) => Either.tryCatch(
          () => labels.map((labelMap) => LabelModel.fromMap(labelMap)).toList(),
          (o, s) => Failure(message: "Failed to parse labels from database"),
        ).toTaskEither());
  }

  @override
  TaskEither<Failure, List<QuoteModel>> getAllQuotes() {
    // TODO: implement getAllQuotes
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, List<SourceModel>> getAllSources() {
    return TaskEither.tryCatch(
      () => db.query('sources'),
      (error, stackTrace) => Failure(
          message:
              'Failed to get sources from DB with error ${error.toString()}'),
    ).flatMap((sources) => Either.tryCatch(
          () => sources
              .map((sourceMap) => SourceModel.fromMap(sourceMap))
              .toList(),
          (o, s) => Failure(
              message: 'Failed to parse sources with error ${o.toString()}'),
        ).toTaskEither());
  }

  @override
  TaskEither<Failure, Unit> removeAuthorById(String id) {
    return Either.tryCatch(
      () => int.parse(id),
      (o, s) => Failure(
          message: 'The id is not a valid int with error ${o.toString()}'),
    ).toTaskEither().flatMap((idAsInt) => TaskEither.tryCatch(
          () async {
            await db.delete('authors', where: 'id = ?', whereArgs: [idAsInt]);
            return unit;
          },
          (error, stackTrace) => Failure(
              message:
                  'Failed to delete from DB with error ${error.toString()}'),
        ));
  }

  @override
  TaskEither<Failure, Unit> removeLabelById(String id) {
    return Either.tryCatch(
      () => int.parse(id),
      (o, s) => Failure(
          message: "The id is not a valid int with error ${o.toString()}"),
    ).toTaskEither().flatMap((idAsInt) => TaskEither.tryCatch(
          () async {
            await db.delete('label', where: 'id = ?', whereArgs: [idAsInt]);
            return unit;
          },
          (error, stackTrace) => Failure(
              message:
                  'Failed to delete from DB with error ${error.toString()}'),
        ));
  }

  @override
  TaskEither<Failure, Unit> removeQuoteById(String id) {
    // TODO: implement removeQuoteById
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Unit> removeSourceById(String id) {
    return Either.tryCatch(
      () => int.parse(id),
      (o, s) => Failure(
          message: 'The id is not a valid int with error ${o.toString()}'),
    ).toTaskEither().flatMap((idAsInt) => TaskEither.tryCatch(
          () async {
            await db.delete('sources', where: 'id = ?', whereArgs: [idAsInt]);
            return unit;
          },
          (error, stackTrace) => Failure(
              message:
                  'Failed to delete from DB with error ${error.toString()}'),
        ));
  }

  @override
  TaskEither<Failure, Unit> uploadAuthor(String author) {
    return TaskEither.tryCatch(
      () async {
        await db.insert('authors', {'author': author});
        return unit;
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to insert author in DB with error ${error.toString()}'),
    );
  }

  @override
  TaskEither<Failure, Unit> uploadLabel(String label) {
    return TaskEither.tryCatch(
      () async {
        await db.insert('label', {'label': label});
        return unit;
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to insert label in DB with error ${error.toString()}'),
    );
  }

  @override
  TaskEither<Failure, Unit> uploadQuote(String authorId, String labelId,
      String sourceId, String details, String content) {
    // TODO: implement uploadQuote
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Unit> uploadSource(String source) {
    return TaskEither.tryCatch(
      () async {
        await db.insert('sources', {'source': source});
        return unit;
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to insert source in DB with error ${error.toString()}'),
    );
  }
}
