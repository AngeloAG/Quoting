import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthorsRepository {
  Future<Either<Failure, dynamic>> removeAuthorById(String authorId);

  Future<Either<Failure, Author>> uploadAuthor(
      CreateAuthorWork createAuthorWork);

  Future<Either<Failure, List<Author>>> getAllAuthors();
}
