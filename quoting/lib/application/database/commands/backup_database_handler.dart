import 'dart:io';
import 'package:quoting/application/common/interfaces/database_file_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class BackupDatabaseRequest extends IRequest<Either<Failure, File>> {
  final String backupPath;
  BackupDatabaseRequest(this.backupPath);
}

class BackupDatabaseHandler
    extends IRequestHandler<BackupDatabaseRequest, Either<Failure, File>> {
  final IDatabaseFileRepository repository;
  BackupDatabaseHandler(this.repository);

  @override
  Future<Either<Failure, File>> call(BackupDatabaseRequest request) {
    return repository.backupDatabase(backupPath: request.backupPath).run();
  }
}
