import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/author_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthorsDataSource {
  TaskEither<Failure, AuthorModel> uploadAuthor(String author);

  TaskEither<Failure, Unit> removeAuthorById(String id);

  TaskEither<Failure, Stream<List<AuthorModel>>> getAllAuthors();

  TaskEither<Failure, Unit> updateAuthor(AuthorModel author);
}
