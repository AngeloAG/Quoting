import 'package:quoting/application/common/interfaces/database_file_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RestoreDatabaseRequest extends IRequest<Either<Failure, Unit>> {
  final String backupPath;
  RestoreDatabaseRequest(this.backupPath);
}

class RestoreDatabaseHandler
    extends IRequestHandler<RestoreDatabaseRequest, Either<Failure, Unit>> {
  final IDatabaseFileRepository repository;
  RestoreDatabaseHandler(this.repository);

  @override
  Future<Either<Failure, Unit>> call(RestoreDatabaseRequest request) {
    return repository.restoreDatabase(backupPath: request.backupPath).run();
  }
}
