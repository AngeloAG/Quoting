import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/infrastructure/common/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthDataSource {
  TaskEither<Failure, UserModel> signUpEmailAndPassword(
      String email, String password);

  TaskEither<Failure, UserModel> loginEmailAndPassword(
      String email, String password);
}
