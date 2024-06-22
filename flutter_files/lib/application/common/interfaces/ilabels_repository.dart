import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:flutter_files/domain/works/update_label_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ILabelsRepository {
  TaskEither<Failure, Unit> removeLabelById(String labelId);

  TaskEither<Failure, Label> uploadLabel(CreateLabelWork createLabelWork);

  TaskEither<Failure, List<Label>> getAllLabels();

  TaskEither<Failure, Unit> updateLabel(UpdateLabelWork updateLabelWork);
}
