import 'dart:io';

import 'package:quoting/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IDatabaseFileRepository {
  TaskEither<Failure, File> backupDatabase({required String backupPath});
  TaskEither<Failure, Unit> restoreDatabase({required String backupPath});
}
