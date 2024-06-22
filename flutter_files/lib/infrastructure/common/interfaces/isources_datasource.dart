import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/source_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISourcesDataSource {
  TaskEither<Failure, SourceModel> uploadSource(String source);

  TaskEither<Failure, Unit> removeSourceById(String id);

  TaskEither<Failure, List<SourceModel>> getAllSources();

  TaskEither<Failure, Unit> updateSource(SourceModel source);
}
