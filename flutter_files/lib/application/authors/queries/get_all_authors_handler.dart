import 'package:flutter_files/application/common/interfaces/iauthors_repository.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class GetAllAuthorsRequest
    extends IRequest<Either<Failure, Stream<List<Author>>>> {}

class GetAllAuthorsHandler extends IRequestHandler<GetAllAuthorsRequest,
    Either<Failure, Stream<List<Author>>>> {
  final IAuthorsRepository iAuthorsRepository;

  GetAllAuthorsHandler(this.iAuthorsRepository);

  @override
  Future<Either<Failure, Stream<List<Author>>>> call(
      GetAllAuthorsRequest request) {
    return iAuthorsRepository.getAllAuthors().run();
  }
}
