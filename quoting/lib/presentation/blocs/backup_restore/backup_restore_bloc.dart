import 'package:bloc/bloc.dart';
import 'package:mediatr/mediatr.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quoting/application/database/commands/backup_database_handler.dart';
import 'package:quoting/application/database/commands/restore_database_handler.dart';
import 'package:quoting/domain/models/failure.dart';
import 'dart:io';

part 'backup_restore_event.dart';
part 'backup_restore_state.dart';

class BackupRestoreBloc extends Bloc<BackupRestoreEvent, BackupRestoreState> {
  final Mediator _mediator;

  BackupRestoreBloc({required Mediator mediator})
      : _mediator = mediator,
        super(BackupRestoreInitial()) {
    on<BackupDatabaseRequested>(_onBackupDatabaseRequested);
    on<RestoreDatabaseRequested>(_onRestoreDatabaseRequested);
  }

  Future<void> _onBackupDatabaseRequested(
      BackupDatabaseRequested event, Emitter<BackupRestoreState> emit) async {
    emit(BackupRestoreInProgress());
    final response =
        await _mediator.send<BackupDatabaseRequest, Either<Failure, File>>(
      BackupDatabaseRequest(event.savePath),
    );
    response.fold(
      (failure) => emit(BackupRestoreFailure(error: failure.message)),
      (file) =>
          emit(BackupRestoreSuccess(message: 'Backup completed: ${file.path}')),
    );
  }

  Future<void> _onRestoreDatabaseRequested(
      RestoreDatabaseRequested event, Emitter<BackupRestoreState> emit) async {
    emit(BackupRestoreInProgress());
    final response =
        await _mediator.send<RestoreDatabaseRequest, Either<Failure, Unit>>(
      RestoreDatabaseRequest(event.backupPath),
    );
    response.fold(
      (failure) => emit(BackupRestoreFailure(error: failure.message)),
      (_) => emit(
          BackupRestoreSuccess(message: 'Restore completed successfully.')),
    );
  }
}
