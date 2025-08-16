import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/label.dart';
import 'package:quoting/domain/works/create_label_work.dart';
import 'package:quoting/domain/works/update_label_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ILabelsRepository {
  TaskEither<Failure, Unit> removeLabelById(String labelId);

  TaskEither<Failure, Label> uploadLabel(CreateLabelWork createLabelWork);

  TaskEither<Failure, Stream<List<Label>>> getAllLabels();

  TaskEither<Failure, Unit> updateLabel(UpdateLabelWork updateLabelWork);
}
