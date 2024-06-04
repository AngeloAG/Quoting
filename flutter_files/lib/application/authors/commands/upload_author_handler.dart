import 'package:flutter_files/application/common/interfaces/iauthors_repository.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
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
    return iAuthorsRepository.uploadAuthor(request.createAuthorWork);
  }
}
