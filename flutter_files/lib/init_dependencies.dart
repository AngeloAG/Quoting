import 'package:flutter_files/presentation/blocs/label/label_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator
      .registerLazySingleton(() => LabelBloc(mediator: serviceLocator()));
}
