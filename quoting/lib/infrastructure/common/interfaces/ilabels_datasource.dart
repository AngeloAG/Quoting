import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/works/update_label_work.dart';
import 'package:quoting/infrastructure/common/models/label_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ILabelsDataSource {
  TaskEither<Failure, LabelModel> uploadLabel(String label);

  TaskEither<Failure, Unit> removeLabelById(String id);

  TaskEither<Failure, Stream<List<LabelModel>>> getAllLabels();

  TaskEither<Failure, Unit> updateLabel(UpdateLabelWork updateLabelWork);
}
