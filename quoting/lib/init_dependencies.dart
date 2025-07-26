import 'package:quoting/application/init_dependencies.dart';
import 'package:quoting/infrastructure/init_dependencies.dart';
import 'package:quoting/presentation/blocs/author/author_bloc.dart';
import 'package:quoting/presentation/blocs/backup_restore/backup_restore_bloc.dart';
import 'package:quoting/presentation/blocs/label/label_bloc.dart';
import 'package:quoting/presentation/blocs/quotes/quote_bloc.dart';
import 'package:quoting/presentation/blocs/source/source_bloc.dart';
import 'package:quoting/presentation/blocs/tabs/tabs_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initApplicationDependencies(serviceLocator);
  await initInfrastructureDependencies(serviceLocator);

  serviceLocator
      .registerLazySingleton(() => LabelBloc(mediator: serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => AuthorBloc(mediator: serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => SourceBloc(mediator: serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => QuoteBloc(mediator: serviceLocator()));

  serviceLocator
      .registerFactory(() => BackupRestoreBloc(mediator: serviceLocator()));

  serviceLocator.registerLazySingleton(() => TabsCubit());
}
