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
  Future<Either<Failure, List<Label>>> getAllLabels() {
    // TODO: implement getAllLabels
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> removeLabelById(String labelId) {
    // TODO: implement removeLabelById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Label>> uploadLabel(
      CreateLabelWork createLabelWork) async {
    print("label created");
    if (createLabelWork.label == "bad") {
      return left(Failure(message: "Failed to create label"));
    }
    return right(Label(id: "sdfgsdfgsdfgs", label: createLabelWork.label));
  }
}
