import 'package:drift/drift.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_quote_work.dart';
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
    return TaskEither.tryCatch(
      () async => driftDB.select(driftDB.authors).get(),
      (error, stackTrace) => Failure(
          message:
              'Failed to get authors from DB with error: ${error.toString()}'),
    ).flatMap((authors) => Either.tryCatch(
          () => authors
              .map((author) => AuthorModel(author.id.toString(), author.name))
              .toList(),
          (o, s) => Failure(
              message: 'Failed to parse authors with error: ${o.toString()}'),
        ).toTaskEither());
  }

  @override
  TaskEither<Failure, List<LabelModel>> getAllLabels() {
    return TaskEither.tryCatch(
      () async => driftDB.select(driftDB.labels).get(),
      (error, stackTrace) => Failure(
          message:
              'Failed to get labels from DB, with error: ${error.toString()}'),
    ).flatMap((labels) => Either.tryCatch(
          () => labels
              .map((label) => LabelModel(label.id.toString(), label.content))
              .toList(),
          (o, s) => Failure(
              message:
                  'Failed to parse labels from database with error: ${o.toString()}'),
        ).toTaskEither());
  }

  @override
  TaskEither<Failure, Stream<List<QuoteModel>>> getAllQuotes() {
    return TaskEither.tryCatch(
      () async {
        return driftDB
            .select(driftDB.quotes)
            .join([
              leftOuterJoin(driftDB.authors,
                  driftDB.authors.id.equalsExp(driftDB.quotes.authorId)),
              leftOuterJoin(driftDB.labels,
                  driftDB.labels.id.equalsExp(driftDB.quotes.labelId)),
              leftOuterJoin(driftDB.sources,
                  driftDB.sources.id.equalsExp(driftDB.quotes.sourceId)),
            ])
            .watch()
            .map((rows) {
              return rows.map((row) {
                final Quote quote = row.readTable(driftDB.quotes);
                final Author? author = row.readTableOrNull(driftDB.authors);
                final Label? label = row.readTableOrNull(driftDB.labels);
                final Source? source = row.readTableOrNull(driftDB.sources);

                return QuoteModel(
                    quote.id.toString(),
                    author?.id.toString(),
                    author?.name,
                    label?.id.toString(),
                    label?.content,
                    source?.content,
                    source?.id.toString(),
                    quote.details,
                    quote.content);
              }).toList();
            });
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to retrieve quotes from the DB with error: ${error.toString()}'),
    );
  }

  @override
  TaskEither<Failure, List<SourceModel>> getAllSources() {
    return TaskEither.tryCatch(
      () async => driftDB.select(driftDB.sources).get(),
      (error, stackTrace) => Failure(
          message:
              'Failed to get sources from DB, with error: ${error.toString()}'),
    ).flatMap((sources) => Either.tryCatch(
          () => sources
              .map(
                  (source) => SourceModel(source.id.toString(), source.content))
              .toList(),
          (o, s) => Failure(
              message:
                  'Failed to parse sources from database with error: ${o.toString()}'),
        ).toTaskEither());
  }

  @override
  TaskEither<Failure, Unit> removeAuthorById(String id) {
    return Either.tryCatch(
      () => int.parse(id),
      (error, stackTrace) => Failure(
          message: 'The id is not a valid int with error: ${error.toString()}'),
    ).toTaskEither().flatMap((idAsInt) => TaskEither.tryCatch(
          () async {
            (driftDB.delete(driftDB.authors)
                  ..where((tbl) => tbl.id.equals(idAsInt)))
                .go();
            return unit;
          },
          (error, stackTrace) => Failure(
              message:
                  'Failed to delete from DB with error: ${error.toString()}'),
        ));
  }

  @override
  TaskEither<Failure, Unit> removeLabelById(String id) {
    return Either.tryCatch(
      () => int.parse(id),
      (o, s) => Failure(
          message: 'The id is not a valid int with error: ${o.toString()}'),
    ).toTaskEither().flatMap((idAsInt) => TaskEither.tryCatch(
          () async {
            (driftDB.delete(driftDB.labels)
                  ..where((tbl) => tbl.id.equals(idAsInt)))
                .go();
            return unit;
          },
          (error, stackTrace) => Failure(
              message:
                  'Failed to delete from DB with error: ${error.toString()}'),
        ));
  }

  @override
  TaskEither<Failure, Unit> removeQuoteById(String id) {
    return Either.tryCatch(
      () => int.parse(id),
      (o, s) => Failure(
          message: 'The id is not a valid int with error: ${o.toString()}'),
    ).toTaskEither().flatMap((idAsInt) => TaskEither.tryCatch(
          () async {
            (driftDB.delete(driftDB.quotes)
                  ..where((tbl) => tbl.id.equals(idAsInt)))
                .go();
            return unit;
          },
          (error, stackTrace) => Failure(
              message:
                  'Failed to delete from DB with error: ${error.toString()}'),
        ));
  }

  @override
  TaskEither<Failure, Unit> removeSourceById(String id) {
    return Either.tryCatch(
      () => int.parse(id),
      (error, stackTrace) => Failure(
          message: 'The id is not a valid int with error: ${error.toString()}'),
    ).toTaskEither().flatMap((idAsInt) => TaskEither.tryCatch(
          () async {
            (driftDB.delete(driftDB.sources)
                  ..where((tbl) => tbl.id.equals(idAsInt)))
                .go();
            return unit;
          },
          (error, stackTrace) => Failure(
              message:
                  'Failed to delete from DB with error: ${error.toString()}'),
        ));
  }

  @override
  TaskEither<Failure, AuthorModel> uploadAuthor(String author) {
    return TaskEither.tryCatch(
      () async => driftDB
          .into(driftDB.authors)
          .insert(AuthorsCompanion(name: Value(author))),
      (error, stackTrace) => Failure(
          message:
              'Failed to insert author in DB with error: ${error.toString()}'),
    )
        .flatMap((authorId) => TaskEither.tryCatch(
              () async {
                return (driftDB.select(driftDB.authors)
                      ..where((tbl) => tbl.id.equals(authorId)))
                    .get();
              },
              (error, stackTrace) => Failure(
                  message:
                      'Failed to retrieve author from DB with error: ${error.toString()}'),
            ))
        .flatMap(
          (authors) => Either.tryCatch(
            () => AuthorModel(authors.first.id.toString(), authors.first.name),
            (o, s) => Failure(
                message:
                    'Failed to parse authors from DB with error: ${o.toString()}'),
          ).toTaskEither(),
        );
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
            (o, s) => Failure(message: 'Failed to parse labels from database'),
          ).toTaskEither(),
        );
  }

  @override
  TaskEither<Failure, Unit> uploadQuote(CreateQuoteWork createQuoteWork) {
    return TaskEither.tryCatch(
      () async {
        driftDB.into(driftDB.quotes).insert(QuotesCompanion(
            authorId: Value(int.parse(createQuoteWork.authorId)),
            labelId: Value(int.parse(createQuoteWork.labelId)),
            sourceId: Value(int.parse(createQuoteWork.sourceId)),
            details: Value(createQuoteWork.details),
            content: Value(createQuoteWork.content)));
        return unit;
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to insert quote in DB with error: ${error.toString()}'),
    );
  }

  @override
  TaskEither<Failure, SourceModel> uploadSource(String source) {
    return TaskEither.tryCatch(
      () async => driftDB
          .into(driftDB.sources)
          .insert(SourcesCompanion(content: Value(source))),
      (error, stackTrace) => Failure(
          message:
              'Failed to insert source in DB with error: ${error.toString()}'),
    )
        .flatMap((sourceId) => TaskEither.tryCatch(
              () async {
                return (driftDB.select(driftDB.sources)
                      ..where((tbl) => tbl.id.equals(sourceId)))
                    .get();
              },
              (error, stackTrace) => Failure(
                  message:
                      'Failed to retrieve source from DB with error: ${error.toString()}'),
            ))
        .flatMap(
          (sources) => Either.tryCatch(
            () =>
                SourceModel(sources.first.id.toString(), sources.first.content),
            (o, s) => Failure(
                message:
                    'Failed to parse source from DB with error: ${o.toString()}'),
          ).toTaskEither(),
        );
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

  @override
  TaskEither<Failure, Unit> updateAuthor(AuthorModel author) {
    return TaskEither.tryCatch(
      () async {
        driftDB.update(driftDB.authors).replace(AuthorsCompanion(
            id: Value(int.parse(author.id)), name: Value(author.author)));
        return unit;
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to update label in DB with error: ${error.toString()}'),
    );
  }

  @override
  TaskEither<Failure, Unit> updateSource(SourceModel source) {
    return TaskEither.tryCatch(
      () async {
        driftDB.update(driftDB.sources).replace(SourcesCompanion(
            id: Value(int.parse(source.id)), content: Value(source.source)));
        return unit;
      },
      (error, stackTrace) => Failure(
          message:
              'Failed to update source in DB with error: ${error.toString()}'),
    );
  }
}
