import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ILabelsRepository {
  Future<Either<Failure, dynamic>> removeLabelById(String labelId);

  Future<Either<Failure, Label>> uploadLabel(CreateLabelWork createLabelWork);

  Future<Either<Failure, List<Label>>> getAllLabels();
}
