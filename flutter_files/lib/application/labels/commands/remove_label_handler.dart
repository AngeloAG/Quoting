import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveLabelRequest extends IRequest<Either<Failure, dynamic>> {
  final String labelId;

  RemoveLabelRequest({required this.labelId});
}

class RemoveLabelHandler
    extends IRequestHandler<RemoveLabelRequest, Either<Failure, dynamic>> {
  final ILabelsRepository iLabelsRepository;

  RemoveLabelHandler(this.iLabelsRepository);

  @override
  Future<Either<Failure, dynamic>> call(RemoveLabelRequest request) {
    return iLabelsRepository.removeLabelById(request.labelId).run();
  }
}
