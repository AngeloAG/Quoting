import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ILabelsRepository {
  Future<Either<String, dynamic>> removeLabelById(String labelId);

  Future<Either<String, Label>> uploadLabel(CreateLabelWork createLabelWork);

  Future<Either<String, List<Label>>> getAllLabels();
}
