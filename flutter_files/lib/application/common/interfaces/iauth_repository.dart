import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthRepository {
  TaskEither<Failure, User> signUpWithEmailAndPassword(
      String email, String password);

  TaskEither<Failure, User> loginWithEmailAndPassword(
      String email, String password);
}
