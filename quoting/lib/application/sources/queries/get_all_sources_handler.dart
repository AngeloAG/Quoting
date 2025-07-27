import 'package:quoting/application/common/interfaces/isources_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class GetAllSourcesRequest
    extends IRequest<Either<Failure, Stream<List<Source>>>> {}

class GetAllSourcesHandler extends IRequestHandler<GetAllSourcesRequest,
    Either<Failure, Stream<List<Source>>>> {
  final ISourcesRepository iSourcesRepository;

  GetAllSourcesHandler(this.iSourcesRepository);

  @override
  Future<Either<Failure, Stream<List<Source>>>> call(
      GetAllSourcesRequest request) {
    return iSourcesRepository.getAllSources().run();
  }
}
