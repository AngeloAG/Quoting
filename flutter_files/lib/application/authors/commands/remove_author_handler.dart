import 'package:flutter_files/application/common/interfaces/iauthors_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveAuthorRequest extends IRequest<Either<Failure, dynamic>> {
  final String authorId;

  RemoveAuthorRequest({required this.authorId});
}

class RemoveAuthorHandler
    extends IRequestHandler<RemoveAuthorRequest, Either<Failure, dynamic>> {
  final IAuthorsRepository iAuthorsRepository;

  RemoveAuthorHandler(this.iAuthorsRepository);

  @override
  Future<Either<Failure, dynamic>> call(RemoveAuthorRequest request) {
    return iAuthorsRepository.removeAuthorById(request.authorId);
  }
}
