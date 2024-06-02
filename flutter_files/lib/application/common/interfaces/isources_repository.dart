import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_source_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISourcesRepository {
  Future<Either<String, dynamic>> removeSourceById(String sourceId);

  Future<Either<String, Source>> uploadSource(
      CreateSourceWork createSourceWork);

  Future<Either<String, List<Source>>> getAllSources();
}
