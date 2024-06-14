import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/label_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ILabelsDataSource {
  TaskEither<Failure, Unit> uploadLabel(String label);

  TaskEither<Failure, Unit> removeLabelById(String id);

  TaskEither<Failure, List<LabelModel>> getAllLabels();
}
