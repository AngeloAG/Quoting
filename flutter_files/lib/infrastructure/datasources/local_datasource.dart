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
    // TODO: implement getAllAuthors
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, List<LabelModel>> getAllLabels() {
    return TaskEither.tryCatch(
      () => db.query('label'),
      (error, stackTrace) => Failure(message: 'Failed to get labels from DB'),
    ).flatMap(
      (labelsMaps) => TaskEither.tryCatch(
          () async => labelsMaps
              .map((labelMap) => LabelModel.fromMap(labelMap))
              .toList(),
          (error, stackTrace) => Failure(message: 'Failed to parse maps')),
    );
  }

  @override
  TaskEither<Failure, List<QuoteModel>> getAllQuotes() {
    // TODO: implement getAllQuotes
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, List<SourceModel>> getAllSources() {
    // TODO: implement getAllSources
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, dynamic> removeAuthorById(String id) {
    // TODO: implement removeAuthorById
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, dynamic> removeLabelById(String id) {
    // TODO: implement removeLabelById
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, dynamic> removeQuoteById(String id) {
    // TODO: implement removeQuoteById
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, dynamic> removeSourceById(String id) {
    // TODO: implement removeSourceById
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, AuthorModel> uploadAuthor(String author) {
    // TODO: implement uploadAuthor
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, LabelModel> uploadLabel(String label) {
    // final labelId = db.insert('labebl', {'laebel': label});
    // final labels = await db.query('label',
    //     columns: ['labebl_id', 'label'],
    //     where: 'labebl_id = ?',
    //     whereArgs: [labelId]);
    // if (labels.isEmpty) {
    //   return TaskEither.left(Failure(message: 'Failed to insert label in database'));
    // } else {
    //   return TaskEither.right(LabelModel.fromMap(labels[0]));
    // }

    return TaskEither.tryCatch(
      () => db.insert('label', {'label': label}),
      (error, stackTrace) => Failure(message: 'Failed to insert label in DB'),
    )
        .flatMap(
          (labelId) => TaskEither.tryCatch(
              () => db.query('label',
                  columns: ['id', 'label'],
                  where: 'id = ?',
                  whereArgs: [labelId]),
              ((error, stackTrace) =>
                  Failure(message: 'Failed to query label from DB'))),
        )
        .flatMap(
          (labelsMaps) => TaskEither.fromEither(labelsMaps.isEmpty
              ? left(Failure(message: 'Failed to retrieve label from DB'))
              : right(LabelModel.fromMap(labelsMaps[0]))),
        );
  }

  @override
  TaskEither<Failure, QuoteModel> uploadQuote(String authorId, String labelId,
      String sourceId, String details, String content) {
    // TODO: implement uploadQuote
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, SourceModel> uploadSource(String source) {
    // TODO: implement uploadSource
    throw UnimplementedError();
  }
}
