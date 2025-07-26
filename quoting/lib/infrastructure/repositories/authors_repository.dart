import 'package:quoting/application/common/interfaces/iauthors_repository.dart';
import 'package:quoting/domain/models/author.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/works/create_author_work.dart';
import 'package:quoting/infrastructure/common/interfaces/iauthors_datasource.dart';
import 'package:quoting/infrastructure/common/models/author_model.dart';
import 'package:fpdart/fpdart.dart';

class AuthorsRepository implements IAuthorsRepository {
  final IAuthorsDataSource iAuthorsDataSource;

  AuthorsRepository(this.iAuthorsDataSource);

  @override
  TaskEither<Failure, Stream<List<Author>>> getAllAuthors() {
    return iAuthorsDataSource.getAllAuthors().map((authorsStream) =>
        authorsStream.map((authorModels) => authorModels
            .map((authorModel) =>
                Author(id: authorModel.id, name: authorModel.author))
            .toList()));
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

  @override
  TaskEither<Failure, Unit> updateAuthor(Author author) {
    return iAuthorsDataSource.updateAuthor(AuthorModel(author.id, author.name));
  }
}
