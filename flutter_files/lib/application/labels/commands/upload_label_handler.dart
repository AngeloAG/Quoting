import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UploadLabelRequest extends IRequest<Either<String, Label>> {
  final CreateLabelWork createLabelWork;

  UploadLabelRequest(this.createLabelWork);
}

class UploadLabelHandler
    extends IRequestHandler<UploadLabelRequest, Either<String, Label>> {
  final ILabelsRepository iLabelsRepository;

  UploadLabelHandler(this.iLabelsRepository);

  @override
  Future<Either<String, Label>> call(UploadLabelRequest request) {
    return iLabelsRepository.uploadLabel(request.createLabelWork);
  }
}
