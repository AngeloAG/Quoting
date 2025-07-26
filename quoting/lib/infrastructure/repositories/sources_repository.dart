import 'package:quoting/application/common/interfaces/isources_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:quoting/domain/works/create_source_work.dart';
import 'package:quoting/infrastructure/common/interfaces/isources_datasource.dart';
import 'package:quoting/infrastructure/common/models/source_model.dart';
import 'package:fpdart/fpdart.dart';

class SourceRepository implements ISourcesRepository {
  final ISourcesDataSource iSourcesDataSource;

  SourceRepository(this.iSourcesDataSource);

  @override
  TaskEither<Failure, Stream<List<Source>>> getAllSources() {
    return iSourcesDataSource.getAllSources().map((sourcesStream) =>
        sourcesStream.map((sourceModels) => sourceModels
            .map((sourceModel) =>
                Source(id: sourceModel.id, source: sourceModel.source))
            .toList()));
  }

  @override
  TaskEither<Failure, Unit> removeSourceById(String sourceId) {
    return iSourcesDataSource.removeSourceById(sourceId);
  }

  @override
  TaskEither<Failure, Source> uploadSource(CreateSourceWork createSourceWork) {
    return iSourcesDataSource.uploadSource(createSourceWork.source).map(
        (sourceModel) =>
            Source(id: sourceModel.id, source: sourceModel.source));
  }

  @override
  TaskEither<Failure, Unit> updateSource(Source source) {
    return iSourcesDataSource
        .updateSource(SourceModel(source.id, source.source));
  }
}
