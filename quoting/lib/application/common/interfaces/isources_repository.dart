import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:quoting/domain/works/create_source_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISourcesRepository {
  TaskEither<Failure, Unit> removeSourceById(String sourceId);

  TaskEither<Failure, Source> uploadSource(CreateSourceWork createSourceWork);

  TaskEither<Failure, Stream<List<Source>>> getAllSources();

  TaskEither<Failure, Unit> updateSource(Source source);
}
