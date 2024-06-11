import 'package:flutter_files/application/init_dependencies.dart';
import 'package:flutter_files/infrastructure/init_dependencies.dart';
import 'package:flutter_files/presentation/blocs/label/label_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initApplicationDependencies(serviceLocator);
  await initInfrastructureDependencies(serviceLocator);

  serviceLocator
      .registerLazySingleton(() => LabelBloc(mediator: serviceLocator()));
}