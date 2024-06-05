import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/label_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ILabelsDataSource {
  Future<Either<Failure, LabelModel>> uploadLabel(String label);

  Future<Either<Failure, dynamic>> removeLabelById(String id);

  Future<Either<Failure, List<LabelModel>>> getAllLabels();
}
