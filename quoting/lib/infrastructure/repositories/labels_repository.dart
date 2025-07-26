import 'package:quoting/application/common/interfaces/ilabels_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/label.dart';
import 'package:quoting/domain/works/create_label_work.dart';
import 'package:quoting/domain/works/update_label_work.dart';
import 'package:quoting/infrastructure/common/interfaces/ilabels_datasource.dart';
import 'package:fpdart/fpdart.dart';

class LabelsRepository implements ILabelsRepository {
  final ILabelsDataSource iLabelsDataSource;

  LabelsRepository(this.iLabelsDataSource);

  @override
  TaskEither<Failure, Stream<List<Label>>> getAllLabels() {
    return iLabelsDataSource.getAllLabels().map((labelsStream) =>
        labelsStream.map((labelModels) => labelModels
            .map((labelModel) =>
                Label(id: labelModel.id, label: labelModel.label))
            .toList()));
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

  @override
  TaskEither<Failure, Unit> updateLabel(UpdateLabelWork updateLabelWork) {
    return iLabelsDataSource.updateLabel(updateLabelWork);
  }
}
