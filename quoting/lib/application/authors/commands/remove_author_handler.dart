import 'package:quoting/application/common/interfaces/iauthors_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveAuthorRequest extends IRequest<Either<Failure, Unit>> {
  final String authorId;

  RemoveAuthorRequest({required this.authorId});
}

class RemoveAuthorHandler
    extends IRequestHandler<RemoveAuthorRequest, Either<Failure, Unit>> {
  final IAuthorsRepository iAuthorsRepository;

  RemoveAuthorHandler(this.iAuthorsRepository);

  @override
  Future<Either<Failure, Unit>> call(RemoveAuthorRequest request) {
    return iAuthorsRepository.removeAuthorById(request.authorId).run();
  }
}
