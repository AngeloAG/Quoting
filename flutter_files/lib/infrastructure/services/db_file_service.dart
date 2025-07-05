import 'dart:io';
import 'package:flutter_files/application/common/interfaces/database_file_repository.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';

class DatabaseFileService implements IDatabaseFileRepository {
  static const String dbFileName = 'db.sqlite';

  @override
  TaskEither<Failure, File> backupDatabase({required String backupPath}) {
    return TaskEither<Failure, File>(
      () async {
        try {
          final dbFolder = await getApplicationDocumentsDirectory();
          final dbFile = File(p.join(dbFolder.path, dbFileName));
          final backupFile = File(backupPath);
          final result = await dbFile.copy(backupFile.path);
          return Either.right(result);
        } catch (e) {
          return Either.left(Failure(message: e.toString()));
        }
      },
    );
  }

  @override
  TaskEither<Failure, Unit> restoreDatabase({required String backupPath}) {
    return TaskEither<Failure, Unit>(
      () async {
        try {
          final dbFolder = await getApplicationDocumentsDirectory();
          final dbFile = File(p.join(dbFolder.path, dbFileName));
          final backupFile = File(backupPath);
          if (await backupFile.exists()) {
            await dbFile.delete().catchError((_) => dbFile);
            await backupFile.copy(dbFile.path);
            return Either.right(unit);
          } else {
            return Either.left(Failure(message: 'Backup file does not exist'));
          }
        } catch (e) {
          return Either.left(Failure(message: e.toString()));
        }
      },
    );
  }
}
