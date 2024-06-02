import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthorsRepository {
  Future<Either<String, dynamic>> removeAuthorById(String authorId);

  Future<Either<String, Author>> uploadAuthor(
      CreateAuthorWork createAuthorWork);

  Future<Either<String, List<Author>>> getAllAuthors();
}
