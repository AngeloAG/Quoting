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
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> initInfrastructureDependencies(GetIt serviceLocator) async {
  var db = await _initDatabase();

  serviceLocator.registerLazySingleton<Database>(() => db);
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
}

Future<Database> _initDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'quoting_db.db');
  return await openDatabase(
    path,
    version: 2,
    onUpgrade: (db, oldVersion, newVersion) async {
      db.execute('''
          drop table if exists labels;

          drop table if exists authors;

          drop table if exists sources;

          drop table if exists quotes;
          ''');
    },
    onCreate: (db, version) async {
      db.execute('''
          drop table if exists labels;
          create table if not exists labels (
            id int not null primary key,
            label text,
          );

          drop table if exists authors;
          create table if not exists authors (
            id int not null primary key,
            author text not null,
          );

          drop table if exists sources;
          create table if not exists sources (
            id int not null primary key,
            source text not null,
          );

          drop table if exists quotes;
          create table if not exists quotes (
            id int not null primary key,
            content text not null,
            details text,
            author_id int,
            label_id int,
            source_id int,
            foreign key (author_id) references authors(id),
            foreign key (label_id) references labels(id),
            foreign key (source_id) references sources(id)
          );
          ''');
    },
  );
}
