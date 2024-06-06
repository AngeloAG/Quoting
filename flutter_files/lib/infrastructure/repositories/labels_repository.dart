import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:flutter_files/infrastructure/common/interfaces/ilabels_datasource.dart';
import 'package:fpdart/fpdart.dart';

class LabelsRepository implements ILabelsRepository {
  final ILabelsDataSource iLabelsDataSource;

  LabelsRepository(this.iLabelsDataSource);

  @override
  TaskEither<Failure, List<Label>> getAllLabels() {
    // TODO: implement getAllLabels
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, dynamic> removeLabelById(String labelId) {
    // TODO: implement removeLabelById
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Label> uploadLabel(CreateLabelWork createLabelWork) {
    var d = Task<Either<String, int>>.of(Either<String, int>.of(10));

    throw UnimplementedError();
  }
}
