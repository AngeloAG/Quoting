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
  TaskEither<Failure, List<Source>> getAllSources() {
    return iSourcesDataSource.getAllSources().map((sourcesModels) =>
        sourcesModels
            .map((sourceModel) =>
                Source(id: sourceModel.id, source: sourceModel.source))
            .toList());
  }

  @override
  TaskEither<Failure, dynamic> removeSourceById(String sourceId) {
    return iSourcesDataSource.removeSourceById(sourceId);
  }

  @override
  TaskEither<Failure, Source> uploadSource(CreateSourceWork createSourceWork) {
    return iSourcesDataSource.uploadSource(createSourceWork.source).map(
        (sourceModel) =>
            Source(id: sourceModel.id, source: sourceModel.source));
  }
}