import 'package:quoting/application/common/interfaces/iauthors_repository.dart';
import 'package:quoting/domain/models/author.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/works/create_author_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UploadAuthorRequest extends IRequest<Either<Failure, Author>> {
  final CreateAuthorWork createAuthorWork;

  UploadAuthorRequest({required this.createAuthorWork});
}

class UploadAuthorHandler
    extends IRequestHandler<UploadAuthorRequest, Either<Failure, Author>> {
  final IAuthorsRepository iAuthorsRepository;

  UploadAuthorHandler(this.iAuthorsRepository);

  @override
  Future<Either<Failure, Author>> call(UploadAuthorRequest request) {
    return iAuthorsRepository.uploadAuthor(request.createAuthorWork).run();
  }
}
