import 'package:flutter_files/application/common/interfaces/isources_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveSourceRequest extends IRequest<Either<Failure, dynamic>> {
  final String sourceId;

  RemoveSourceRequest({required this.sourceId});
}

class RemoveSourceHandler
    extends IRequestHandler<RemoveSourceRequest, Either<Failure, dynamic>> {
  final ISourcesRepository iSourcesRepository;

  RemoveSourceHandler(this.iSourcesRepository);

  @override
  Future<Either<Failure, dynamic>> call(RemoveSourceRequest request) {
    return iSourcesRepository.removeSourceById(request.sourceId).run();
  }
}
