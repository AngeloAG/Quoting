import 'dart:io';

import 'package:quoting/application/authors/commands/remove_author_handler.dart';
import 'package:quoting/application/authors/commands/update_author_handler.dart';
import 'package:quoting/application/authors/commands/upload_author_handler.dart';
import 'package:quoting/application/authors/queries/get_all_authors_handler.dart';
import 'package:quoting/application/database/commands/backup_database_handler.dart';
import 'package:quoting/application/database/commands/restore_database_handler.dart';
import 'package:quoting/application/labels/commands/remove_label_handler.dart';
import 'package:quoting/application/labels/commands/update_label_handler.dart';
import 'package:quoting/application/labels/commands/upload_label_handler.dart';
import 'package:quoting/application/labels/queries/get_all_labels_handler.dart';
import 'package:quoting/application/quotes/commands/remove_quote_handler.dart';
import 'package:quoting/application/quotes/commands/update_quote_handler.dart';
import 'package:quoting/application/quotes/commands/upload_quote_handler.dart';
import 'package:quoting/application/quotes/queries/get_all_quotes_handler.dart';
import 'package:quoting/application/quotes/queries/get_filtered_quotes_handler.dart';
import 'package:quoting/application/quotes/queries/get_paginated_quotes_handler.dart';
import 'package:quoting/application/quotes/queries/search_quote_handler.dart';
import 'package:quoting/application/sources/commands/remove_source_handler.dart';
import 'package:quoting/application/sources/commands/update_source_handler.dart';
import 'package:quoting/application/sources/commands/upload_source_handler.dart';
import 'package:quoting/application/sources/queries/get_all_sources_handler.dart';
import 'package:quoting/domain/models/author.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/label.dart';
import 'package:quoting/domain/models/quote.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:mediatr/mediatr.dart';

Future<void> initApplicationDependencies(GetIt serviceLocator) async {
  final mediator = Mediator(Pipeline());

  mediator.registerHandler<UploadLabelRequest, Either<Failure, Label>,
      UploadLabelHandler>(() => UploadLabelHandler(serviceLocator()));

  mediator.registerHandler<RemoveLabelRequest, Either<Failure, Unit>,
      RemoveLabelHandler>(() => RemoveLabelHandler(serviceLocator()));

  mediator.registerHandler<
      GetAllLabelsRequest,
      Either<Failure, Stream<List<Label>>>,
      GetAllLabelsHandler>(() => GetAllLabelsHandler(serviceLocator()));

  mediator.registerHandler<UpdateLabelRequest, Either<Failure, Unit>,
      UpdateLabelHandler>(() => UpdateLabelHandler(serviceLocator()));

  mediator.registerHandler<UploadAuthorRequest, Either<Failure, Author>,
      UploadAuthorHandler>(() => UploadAuthorHandler(serviceLocator()));

  mediator.registerHandler<RemoveAuthorRequest, Either<Failure, Unit>,
      RemoveAuthorHandler>(() => RemoveAuthorHandler(serviceLocator()));

  mediator.registerHandler<
      GetAllAuthorsRequest,
      Either<Failure, Stream<List<Author>>>,
      GetAllAuthorsHandler>(() => GetAllAuthorsHandler(serviceLocator()));

  mediator.registerHandler<UploadSourceRequest, Either<Failure, Source>,
      UploadSourceHandler>(() => UploadSourceHandler(serviceLocator()));

  mediator.registerHandler<UpdateAuthorRequest, Either<Failure, Unit>,
      UpdateAuthorHandler>(() => UpdateAuthorHandler(serviceLocator()));

  mediator.registerHandler<RemoveSourceRequest, Either<Failure, Unit>,
      RemoveSourceHandler>(() => RemoveSourceHandler(serviceLocator()));

  mediator.registerHandler<
      GetAllSourcesRequest,
      Either<Failure, Stream<List<Source>>>,
      GetAllSourcesHandler>(() => GetAllSourcesHandler(serviceLocator()));

  mediator.registerHandler<UpdateSourceRequest, Either<Failure, Unit>,
      UpdateSourceHandler>(() => UpdateSourceHandler(serviceLocator()));

  mediator.registerHandler<UploadQuoteRequest, Either<Failure, Unit>,
      UploadQuoteHandler>(() => UploadQuoteHandler(serviceLocator()));

  mediator.registerHandler<RemoveQuoteRequest, Either<Failure, Unit>,
      RemoveQuoteHandler>(() => RemoveQuoteHandler(serviceLocator()));

  mediator.registerHandler<GetAllQuotesRequest, Either<Failure, List<Quote>>,
      GetAllQuotesHandler>(() => GetAllQuotesHandler(serviceLocator()));

  mediator.registerHandler<UpdateQuoteRequest, Either<Failure, Unit>,
      UpdateQuoteHandler>(() => UpdateQuoteHandler(serviceLocator()));

  mediator.registerHandler<GetPaginatedQuotesRequest,
          Either<Failure, List<Quote>>, GetPaginatedQuotesHandler>(
      () => GetPaginatedQuotesHandler(serviceLocator()));

  mediator.registerHandler<SearchQuoteRequest, Either<Failure, List<Quote>>,
      SearchQuoteHandler>(() => SearchQuoteHandler(serviceLocator()));

  mediator.registerHandler<BackupDatabaseRequest, Either<Failure, File>,
      BackupDatabaseHandler>(() => BackupDatabaseHandler(serviceLocator()));

  mediator.registerHandler<RestoreDatabaseRequest, Either<Failure, Unit>,
      RestoreDatabaseHandler>(() => RestoreDatabaseHandler(serviceLocator()));

  mediator.registerHandler<GetFilteredQuotesRequest,
          Either<Failure, List<Quote>>, GetFilteredQuotesHandler>(
      () => GetFilteredQuotesHandler(serviceLocator()));

  serviceLocator.registerLazySingleton(() => mediator);
}
