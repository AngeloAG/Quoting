import 'package:flutter_files/application/authors/commands/remove_author_handler.dart';
import 'package:flutter_files/application/authors/commands/upload_author_handler.dart';
import 'package:flutter_files/application/authors/queries/get_all_authors_handler.dart';
import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/application/labels/commands/remove_label_handler.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
import 'package:flutter_files/application/labels/queries/get_all_labels_handler.dart';
import 'package:flutter_files/application/quotes/commands/remove_quote_handler.dart';
import 'package:flutter_files/application/quotes/commands/upload_quote_handler.dart';
import 'package:flutter_files/application/quotes/queries/get_all_quotes_handler.dart';
import 'package:flutter_files/application/sources/commands/remove_source_handler.dart';
import 'package:flutter_files/application/sources/commands/upload_source_handler.dart';
import 'package:flutter_files/application/sources/queries/get_all_sources_handler.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/infrastructure/repositories/labels_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:mediatr/mediatr.dart';

Future<void> initApplicationDependencies(GetIt serviceLocator) async {
  _initRepos(serviceLocator);

  final mediator = Mediator(Pipeline());

  mediator.registerHandler<UploadLabelRequest, Either<Failure, Label>,
      UploadLabelHandler>(() => UploadLabelHandler(serviceLocator()));

  mediator.registerHandler<RemoveLabelRequest, Either<Failure, dynamic>,
      RemoveLabelHandler>(() => RemoveLabelHandler(serviceLocator()));

  mediator.registerHandler<GetAllLabelsRequest, Either<Failure, List<Label>>,
      GetAllLabelsHandler>(() => GetAllLabelsHandler(serviceLocator()));

  mediator.registerHandler<UploadAuthorRequest, Either<Failure, Author>,
      UploadAuthorHandler>(() => UploadAuthorHandler(serviceLocator()));

  mediator.registerHandler<RemoveAuthorRequest, Either<Failure, dynamic>,
      RemoveAuthorHandler>(() => RemoveAuthorHandler(serviceLocator()));

  mediator.registerHandler<GetAllAuthorsRequest, Either<Failure, List<Author>>,
      GetAllAuthorsHandler>(() => GetAllAuthorsHandler(serviceLocator()));

  mediator.registerHandler<UploadSourceRequest, Either<Failure, Source>,
      UploadSourceHandler>(() => UploadSourceHandler(serviceLocator()));

  mediator.registerHandler<RemoveSourceRequest, Either<Failure, dynamic>,
      RemoveSourceHandler>(() => RemoveSourceHandler(serviceLocator()));

  mediator.registerHandler<GetAllSourcesRequest, Either<Failure, List<Source>>,
      GetAllSourcesHandler>(() => GetAllSourcesHandler(serviceLocator()));

  mediator.registerHandler<UploadQuoteRequest, Either<Failure, Quote>,
      UploadQuoteHandler>(() => UploadQuoteHandler(serviceLocator()));

  mediator.registerHandler<RemoveQuoteRequest, Either<Failure, dynamic>,
      RemoveQuoteHandler>(() => RemoveQuoteHandler(serviceLocator()));

  mediator.registerHandler<GetAllQuotesRequest, Either<Failure, List<Quote>>,
      GetAllQuotesHandler>(() => GetAllQuotesHandler(serviceLocator()));

  serviceLocator.registerLazySingleton(() => mediator);
}

void _initRepos(GetIt serviceLocator) {
  serviceLocator.registerFactory<ILabelsRepository>(() => LabelsRepository());
}
