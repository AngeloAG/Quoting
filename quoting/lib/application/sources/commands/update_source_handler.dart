import 'package:quoting/application/common/interfaces/isources_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UpdateSourceRequest extends IRequest<Either<Failure, Unit>> {
  final Source source;

  UpdateSourceRequest({required this.source});
}

class UpdateSourceHandler
    extends IRequestHandler<UpdateSourceRequest, Either<Failure, Unit>> {
  final ISourcesRepository iSourcesRepository;

  UpdateSourceHandler(this.iSourcesRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateSourceRequest request) {
    return iSourcesRepository.updateSource(request.source).run();
  }
}
