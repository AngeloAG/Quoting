import 'package:flutter_files/application/common/interfaces/iauthors_repository.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
import 'package:fpdart/fpdart.dart';

class AuthorsRepository implements IAuthorsRepository {
  @override
  Future<Either<Failure, List<Author>>> getAllAuthors() {
    // TODO: implement getAllAuthors
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> removeAuthorById(String authorId) {
    // TODO: implement removeAuthorById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Author>> uploadAuthor(
      CreateAuthorWork createAuthorWork) {
    // TODO: implement uploadAuthor
    throw UnimplementedError();
  }
}
