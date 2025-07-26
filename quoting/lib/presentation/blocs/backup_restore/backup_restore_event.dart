part of 'backup_restore_bloc.dart';

abstract class BackupRestoreEvent {}

class BackupDatabaseRequested extends BackupRestoreEvent {
  final String savePath;
  BackupDatabaseRequested({required this.savePath});
}

class RestoreDatabaseRequested extends BackupRestoreEvent {
  final String backupPath;
  RestoreDatabaseRequested({required this.backupPath});
}
