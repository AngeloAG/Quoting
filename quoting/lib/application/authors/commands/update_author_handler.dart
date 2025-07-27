import 'package:quoting/application/common/interfaces/iauthors_repository.dart';
import 'package:quoting/domain/models/author.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UpdateAuthorRequest extends IRequest<Either<Failure, Unit>> {
  final Author author;

  UpdateAuthorRequest({required this.author});
}

class UpdateAuthorHandler
    extends IRequestHandler<UpdateAuthorRequest, Either<Failure, Unit>> {
  final IAuthorsRepository iAuthorsRepository;

  UpdateAuthorHandler(this.iAuthorsRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateAuthorRequest request) {
    return iAuthorsRepository.updateAuthor(request.author).run();
  }
}
