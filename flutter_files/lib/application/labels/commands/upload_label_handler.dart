import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UploadLabelRequest extends IRequest<Either<Failure, Unit>> {
  final CreateLabelWork createLabelWork;

  UploadLabelRequest({required this.createLabelWork});
}

class UploadLabelHandler
    extends IRequestHandler<UploadLabelRequest, Either<Failure, Unit>> {
  final ILabelsRepository iLabelsRepository;

  UploadLabelHandler(this.iLabelsRepository);

  @override
  Future<Either<Failure, Unit>> call(UploadLabelRequest request) {
    return iLabelsRepository.uploadLabel(request.createLabelWork).run();
  }
}
