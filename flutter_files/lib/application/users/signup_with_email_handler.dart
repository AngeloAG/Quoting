import 'package:flutter_files/application/common/interfaces/iauth_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class SignUpWithEmailRequest implements IRequest<Either<Failure, User>> {
  final String email;
  final String password;

  SignUpWithEmailRequest({required this.email, required this.password});
}

class SignUpWithEmailHandler
    implements IRequestHandler<SignUpWithEmailRequest, Either<Failure, User>> {
  final IAuthRepository iAuthRepository;

  SignUpWithEmailHandler(this.iAuthRepository);

  @override
  Future<Either<Failure, User>> call(SignUpWithEmailRequest request) {
    return iAuthRepository
        .signUpWithEmailAndPassword(request.email, request.password)
        .run();
  }
}
