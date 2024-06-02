import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/infrastructure/repositories/labels_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:mediatr/mediatr.dart';

Future<void> initApplicationDependencies(GetIt serviceLocator) async {
  _initRepos(serviceLocator);

  final mediator = Mediator(Pipeline());

  mediator.registerHandler<UploadLabelRequest, Either<String, Label>,
      UploadLabelHandler>(() => UploadLabelHandler(serviceLocator()));

  serviceLocator.registerLazySingleton(() => mediator);
}

void _initRepos(GetIt serviceLocator) {
  serviceLocator.registerFactory<ILabelsRepository>(() => LabelsRepository());
}
