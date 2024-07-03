import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthorsRepository {
  TaskEither<Failure, Unit> removeAuthorById(String authorId);

  TaskEither<Failure, Author> uploadAuthor(CreateAuthorWork createAuthorWork);

  TaskEither<Failure, Stream<List<Author>>> getAllAuthors();

  TaskEither<Failure, Unit> updateAuthor(Author author);
}
