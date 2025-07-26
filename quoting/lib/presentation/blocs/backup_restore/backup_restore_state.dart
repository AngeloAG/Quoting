part of 'backup_restore_bloc.dart';

abstract class BackupRestoreState {}

class BackupRestoreInitial extends BackupRestoreState {}

class BackupRestoreInProgress extends BackupRestoreState {}

class BackupRestoreSuccess extends BackupRestoreState {
  final String message;
  BackupRestoreSuccess({required this.message});
}

class BackupRestoreFailure extends BackupRestoreState {
  final String error;
  BackupRestoreFailure({required this.error});
}
