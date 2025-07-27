import 'package:quoting/application/common/interfaces/ilabels_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveLabelRequest extends IRequest<Either<Failure, Unit>> {
  final String labelId;

  RemoveLabelRequest({required this.labelId});
}

class RemoveLabelHandler
    extends IRequestHandler<RemoveLabelRequest, Either<Failure, Unit>> {
  final ILabelsRepository iLabelsRepository;

  RemoveLabelHandler(this.iLabelsRepository);

  @override
  Future<Either<Failure, Unit>> call(RemoveLabelRequest request) {
    return iLabelsRepository.removeLabelById(request.labelId).run();
  }
}
