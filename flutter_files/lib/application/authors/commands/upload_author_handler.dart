import 'package:flutter_files/application/common/interfaces/iauthors_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UploadAuthorRequest extends IRequest<Either<Failure, Unit>> {
  final CreateAuthorWork createAuthorWork;

  UploadAuthorRequest({required this.createAuthorWork});
}

class UploadAuthorHandler
    extends IRequestHandler<UploadAuthorRequest, Either<Failure, Unit>> {
  final IAuthorsRepository iAuthorsRepository;

  UploadAuthorHandler(this.iAuthorsRepository);

  @override
  Future<Either<Failure, Unit>> call(UploadAuthorRequest request) {
    return iAuthorsRepository.uploadAuthor(request.createAuthorWork).run();
  }
}
