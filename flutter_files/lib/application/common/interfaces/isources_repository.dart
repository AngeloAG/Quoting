import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_source_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISourcesRepository {
  TaskEither<Failure, dynamic> removeSourceById(String sourceId);

  TaskEither<Failure, Source> uploadSource(CreateSourceWork createSourceWork);

  TaskEither<Failure, List<Source>> getAllSources();
}
