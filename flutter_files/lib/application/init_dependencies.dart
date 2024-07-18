import 'package:flutter_files/application/authors/commands/remove_author_handler.dart';
import 'package:flutter_files/application/authors/commands/update_author_handler.dart';
import 'package:flutter_files/application/authors/commands/upload_author_handler.dart';
import 'package:flutter_files/application/authors/queries/get_all_authors_handler.dart';
import 'package:flutter_files/application/labels/commands/remove_label_handler.dart';
import 'package:flutter_files/application/labels/commands/update_label_handler.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
import 'package:flutter_files/application/labels/queries/get_all_labels_handler.dart';
import 'package:flutter_files/application/quotes/commands/remove_quote_handler.dart';
import 'package:flutter_files/application/quotes/commands/upload_quote_handler.dart';
import 'package:flutter_files/application/quotes/queries/get_all_quotes_handler.dart';
import 'package:flutter_files/application/quotes/queries/get_paginated_quotes_handler.dart';
import 'package:flutter_files/application/sources/commands/remove_source_handler.dart';
import 'package:flutter_files/application/sources/commands/update_source_handler.dart';
import 'package:flutter_files/application/sources/commands/upload_source_handler.dart';
import 'package:flutter_files/application/sources/queries/get_all_sources_handler.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/domain/models/source.dart';
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

  mediator.registerHandler<GetPaginatedQuotesRequest,
          Either<Failure, List<Quote>>, GetPaginatedQuotesHandler>(
      () => GetPaginatedQuotesHandler(serviceLocator()));

  serviceLocator.registerLazySingleton(() => mediator);
}
