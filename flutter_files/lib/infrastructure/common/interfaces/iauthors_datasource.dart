import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/author_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthorsDataSource {
  Future<Either<Failure, AuthorModel>> uploadAuthor(String author);

  Future<Either<Failure, dynamic>> removeAuthorById(String id);

  Future<Either<Failure, List<AuthorModel>>> getAllAuthors();
}
