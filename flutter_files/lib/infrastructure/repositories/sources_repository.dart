import 'package:flutter_files/application/common/interfaces/isources_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_source_work.dart';
import 'package:flutter_files/infrastructure/common/interfaces/isources_datasource.dart';
import 'package:fpdart/fpdart.dart';

class SourceRepository implements ISourcesRepository {
  final ISourcesDataSource iSourcesDataSource;

  SourceRepository(this.iSourcesDataSource);

  @override
  Future<Either<Failure, List<Source>>> getAllSources() {
    // TODO: implement getAllSources
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> removeSourceById(String sourceId) {
    // TODO: implement removeSourceById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Source>> uploadSource(
      CreateSourceWork createSourceWork) {
    // TODO: implement uploadSource
    throw UnimplementedError();
  }
}
