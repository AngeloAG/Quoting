import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:fpdart/src/either.dart';

class LabelsRepository implements ILabelsRepository {
  @override
  Future<Either<String, List<Label>>> getAllLabels() {
    // TODO: implement getAllLabels
    throw UnimplementedError();
  }

  @override
  Future<Either<String, dynamic>> removeLabelById(String labelId) {
    // TODO: implement removeLabelById
    throw UnimplementedError();
  }

  @override
  Future<Either<String, Label>> uploadLabel(
      CreateLabelWork createLabelWork) async {
    print("label created");
    if (createLabelWork.label == "bad") {
      return left("Failed to create label");
    }
    return right(Label(id: "sdfgsdfgsdfgs", label: createLabelWork.label));
  }
}
