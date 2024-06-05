import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/source_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISourcesDataSource {
  Future<Either<Failure, SourceModel>> uploadSource(String source);

  Future<Either<Failure, dynamic>> removeSourceById(String id);

  Future<Either<Failure, List<SourceModel>>> getAllSources();
}
