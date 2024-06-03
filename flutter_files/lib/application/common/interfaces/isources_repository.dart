import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_source_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISourcesRepository {
  Future<Either<Failure, dynamic>> removeSourceById(String sourceId);

  Future<Either<Failure, Source>> uploadSource(
      CreateSourceWork createSourceWork);

  Future<Either<Failure, List<Source>>> getAllSources();
}
