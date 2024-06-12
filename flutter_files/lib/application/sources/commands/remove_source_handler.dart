import 'package:flutter_files/application/common/interfaces/isources_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveSourceRequest extends IRequest<Either<Failure, Unit>> {
  final String sourceId;

  RemoveSourceRequest({required this.sourceId});
}

class RemoveSourceHandler
    extends IRequestHandler<RemoveSourceRequest, Either<Failure, Unit>> {
  final ISourcesRepository iSourcesRepository;

  RemoveSourceHandler(this.iSourcesRepository);

  @override
  Future<Either<Failure, Unit>> call(RemoveSourceRequest request) {
    return iSourcesRepository.removeSourceById(request.sourceId).run();
  }
}
