import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_source_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISourcesRepository {
  TaskEither<Failure, Unit> removeSourceById(String sourceId);

  TaskEither<Failure, Unit> uploadSource(CreateSourceWork createSourceWork);

  TaskEither<Failure, List<Source>> getAllSources();
}
