import 'package:flutter_files/application/common/interfaces/iauth_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class LoginWithEmailRequest implements IRequest<Either<Failure, User>> {
  final String email;
  final String password;

  LoginWithEmailRequest({required this.email, required this.password});
}

class LoginWithEmailHandler
    implements IRequestHandler<LoginWithEmailRequest, Either<Failure, User>> {
  final IAuthRepository iAuthRepository;

  LoginWithEmailHandler(this.iAuthRepository);

  @override
  Future<Either<Failure, User>> call(LoginWithEmailRequest request) {
    return iAuthRepository.loginWithEmailAndPassword(
        request.email, request.password).run();
  }
}
