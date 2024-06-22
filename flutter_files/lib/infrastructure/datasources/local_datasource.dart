import 'package:drift/drift.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/update_label_work.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iauthors_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/ilabels_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iquotes_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/isources_datasource.dart';
import 'package:flutter_files/infrastructure/common/models/author_model.dart';
import 'package:flutter_files/infrastructure/common/models/label_model.dart';
import 'package:flutter_files/infrastructure/common/models/quote_model.dart';
import 'package:flutter_files/infrastructure/common/models/source_model.dart';
import 'package:flutter_files/infrastructure/settings/drift/drift_db.dart';
import 'package:fpdart/fpdart.dart';

class LocalDataSource
    implements
        IQuotesDataSource,
        IAuthorsDataSource,
        ILabelsDataSource,
        ISourcesDataSource {
  final DriftDB driftDB;

  LocalDataSource(this.driftDB);

  @override
  TaskEither<Failure, List<AuthorModel>> getAllAuthors() {
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, List<LabelModel>> getAllLabels() {
    return TaskEither.tryCatch(
      () async => driftDB.select(driftDB.labels).get(),
      (error, stackTrace) => Failure(message: 'Failed to get labels from DB'),
    ).flatMap((labels) => Either.tryCatch(
          () => labels
              .map((label) => LabelModel(label.id.toString(), label.content))
              .toList(),
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
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Unit> removeAuthorById(String id) {
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Unit> removeLabelById(String id) {
    return Either.tryCatch(
      () => int.parse(id),
      (o, s) => Failure(
          message: "The id is not a valid int with error ${o.toString()}"),
    ).toTaskEither().flatMap((idAsInt) => TaskEither.tryCatch(
          () async {
            (driftDB.delete(driftDB.labels)
                  ..where((tbl) => tbl.id.equals(int.parse(id))))
                .go();
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
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, AuthorModel> uploadAuthor(String author) {
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, LabelModel> uploadLabel(String label) {
    return TaskEither.tryCatch(
      () async {
        return driftDB
            .into(driftDB.labels)
            .insert(LabelsCompanion(content: Value(label)));
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to insert label in DB with error ${error.toString()}'),
    )
        .flatMap(
          (labelId) => TaskEither.tryCatch(() async {
            return (driftDB.select(driftDB.labels)
                  ..where((tbl) => tbl.id.equals(labelId)))
                .get();
          },
              (error, stackTrace) => Failure(
                  message:
                      'Failed to retrieve label from DB with error ${error.toString()}')),
        )
        .flatMap(
          (labelsMaps) => Either.tryCatch(
            () => LabelModel(
                labelsMaps.first.id.toString(), labelsMaps.first.content),
            (o, s) => Failure(message: "Failed to parse labels from database"),
          ).toTaskEither(),
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
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Unit> updateLabel(UpdateLabelWork updateLabelWork) {
    return TaskEither.tryCatch(
      () async {
        driftDB.update(driftDB.labels).replace(LabelsCompanion(
            id: Value(int.parse(updateLabelWork.id)),
            content: Value(updateLabelWork.label)));
        return unit;
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to update label in DB with error: ${error.toString()}'),
    );
  }
}
