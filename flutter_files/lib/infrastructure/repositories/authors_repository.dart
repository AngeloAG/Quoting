import 'package:flutter_files/application/common/interfaces/iauthors_repository.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iauthors_datasource.dart';
import 'package:fpdart/fpdart.dart';

class AuthorsRepository implements IAuthorsRepository {
  final IAuthorsDataSource iAuthorsDataSource;

  AuthorsRepository(this.iAuthorsDataSource);

  @override
  TaskEither<Failure, List<Author>> getAllAuthors() {
    return iAuthorsDataSource.getAllAuthors().map((authorsModels) =>
        authorsModels
            .map((authorModel) =>
                Author(id: authorModel.id, name: authorModel.author))
            .toList());
  }

  @override
  TaskEither<Failure, Unit> removeAuthorById(String authorId) {
    return iAuthorsDataSource.removeAuthorById(authorId);
  }

  @override
  TaskEither<Failure, Author> uploadAuthor(CreateAuthorWork createAuthorWork) {
    return iAuthorsDataSource.uploadAuthor(createAuthorWork.name).map(
        (authorModel) => Author(id: authorModel.id, name: authorModel.author));
  }
}
