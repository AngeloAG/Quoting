import 'package:flutter_files/application/common/interfaces/database_file_repository.dart';
import 'package:flutter_files/application/common/interfaces/iauthors_repository.dart';
import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:flutter_files/application/common/interfaces/isources_repository.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iauthors_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/ilabels_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iquotes_datasource.dart';
import 'package:flutter_files/infrastructure/common/interfaces/isources_datasource.dart';
import 'package:flutter_files/infrastructure/datasources/local_datasource.dart';
import 'package:flutter_files/infrastructure/repositories/authors_repository.dart';
import 'package:flutter_files/infrastructure/repositories/labels_repository.dart';
import 'package:flutter_files/infrastructure/repositories/quotes_repository.dart';
import 'package:flutter_files/infrastructure/repositories/sources_repository.dart';
import 'package:flutter_files/infrastructure/services/db_file_service.dart';
import 'package:flutter_files/infrastructure/settings/drift/drift_db.dart';
import 'package:get_it/get_it.dart';

Future<void> initInfrastructureDependencies(GetIt serviceLocator) async {
  var driftDb = DriftDB();

  serviceLocator.registerLazySingleton<DriftDB>(() => driftDb);

  _initDataSources(serviceLocator);
  _initRepos(serviceLocator);
}

void _initDataSources(GetIt serviceLocator) {
  serviceLocator.registerFactory<ILabelsDataSource>(
    () => LocalDataSource(serviceLocator()),
  );

  serviceLocator.registerFactory<IAuthorsDataSource>(
    () => LocalDataSource(serviceLocator()),
  );

  serviceLocator.registerFactory<ISourcesDataSource>(
    () => LocalDataSource(serviceLocator()),
  );

  serviceLocator.registerFactory<IQuotesDataSource>(
    () => LocalDataSource(serviceLocator()),
  );
}

void _initRepos(GetIt serviceLocator) {
  serviceLocator.registerFactory<ILabelsRepository>(
      () => LabelsRepository(serviceLocator()));

  serviceLocator.registerFactory<IAuthorsRepository>(
      () => AuthorsRepository(serviceLocator()));

  serviceLocator.registerFactory<ISourcesRepository>(
      () => SourceRepository(serviceLocator()));

  serviceLocator.registerFactory<IQuotesRepository>(
      () => QuotesRepository(serviceLocator()));

  serviceLocator
      .registerFactory<IDatabaseFileRepository>(() => DatabaseFileService());
}
