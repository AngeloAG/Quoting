import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveLabelRequest extends IRequest<Either<String, dynamic>> {
  final String labelId;

  RemoveLabelRequest(this.labelId);
}

class RemoveLabelHandler
    extends IRequestHandler<RemoveLabelRequest, Either<String, dynamic>> {
  final ILabelsRepository iLabelsRepository;

  RemoveLabelHandler(this.iLabelsRepository);

  @override
  Future<Either<String, dynamic>> call(RemoveLabelRequest request) {
    return iLabelsRepository.removeLabelById(request.labelId);
  }
}
