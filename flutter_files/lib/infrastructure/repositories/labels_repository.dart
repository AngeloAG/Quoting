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
    return iLabelsDataSource.getAllLabels().map((labelsModels) => labelsModels
        .map((labelModel) => Label(id: labelModel.id, label: labelModel.label))
        .toList());
  }

  @override
  TaskEither<Failure, Unit> removeLabelById(String labelId) {
    return iLabelsDataSource.removeLabelById(labelId);
  }

  @override
  TaskEither<Failure, Label> uploadLabel(CreateLabelWork createLabelWork) {
    return iLabelsDataSource
        .uploadLabel(createLabelWork.label)
        .map((labelModel) => Label(id: labelModel.id, label: labelModel.label));
  }
}
