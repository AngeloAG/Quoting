import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/infrastructure/common/models/source_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISourcesDataSource {
  TaskEither<Failure, SourceModel> uploadSource(String source);

  TaskEither<Failure, Unit> removeSourceById(String id);

  TaskEither<Failure, Stream<List<SourceModel>>> getAllSources();

  TaskEither<Failure, Unit> updateSource(SourceModel source);
}
