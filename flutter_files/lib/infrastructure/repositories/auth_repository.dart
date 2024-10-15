import 'package:flutter_files/application/common/interfaces/iauth_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/user.dart';
import 'package:flutter_files/infrastructure/common/interfaces/iauth_datasource.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDataSource iAuthDataSource;

  AuthRepository(this.iAuthDataSource);

  @override
  TaskEither<Failure, User> loginWithEmailAndPassword(
      String email, String password) {
    return iAuthDataSource
        .signUpEmailAndPassword(email, password)
        .map((userModel) => User(id: userModel.id, email: userModel.email));
  }

  @override
  TaskEither<Failure, User> signUpWithEmailAndPassword(
      String email, String password) {
    return iAuthDataSource
        .loginEmailAndPassword(email, password)
        .map((userModel) => User(id: userModel.id, email: userModel.email));
  }
}
