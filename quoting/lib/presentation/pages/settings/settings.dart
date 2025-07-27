import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_selector/file_selector.dart';
import 'package:quoting/presentation/blocs/author/author_bloc.dart';
import 'package:quoting/presentation/blocs/backup_restore/backup_restore_bloc.dart';
import 'package:quoting/presentation/blocs/label/label_bloc.dart';
import 'package:quoting/presentation/blocs/quotes/quote_bloc.dart';
import 'package:quoting/presentation/blocs/source/source_bloc.dart';
import 'package:quoting/presentation/shared/utilities.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDisposed = false;

  Future<void> _pickBackupLocation() async {
    final bloc = context.read<BackupRestoreBloc>();
    String? outputFile;
    String? dir;
    try {
      dir = await getDirectoryPath(
        confirmButtonText: 'Select Folder',
      );
      if (_isDisposed) return;
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Not Supported'),
          content: const Text('Backup is not supported on this platform.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    if (_isDisposed || !mounted) return;
    if (dir != null && dir.isNotEmpty) {
      String fileName = 'quotes_backup.db';
      final nameController = TextEditingController(text: fileName);
      final enteredName = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enter backup file name'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'File name'),
            controller: nameController,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (enteredName != null && enteredName.isNotEmpty) {
        outputFile =
            dir.endsWith('/') ? '$dir$enteredName' : '$dir/$enteredName';
      }
    }
    if (_isDisposed || !mounted) return;
    if (outputFile != null && outputFile.isNotEmpty) {
      bloc.add(BackupDatabaseRequested(savePath: outputFile));
    }
  }

  Future<void> _pickRestoreFile() async {
    final bloc = context.read<BackupRestoreBloc>();
    final typeGroup = XTypeGroup(label: 'Database', extensions: ['db']);
    XFile? file;
    try {
      file = await openFile(acceptedTypeGroups: [typeGroup]);
      if (_isDisposed) return;
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Not Supported'),
          content: const Text('Restore is not supported on this platform.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    if (_isDisposed || !mounted) return;
    if (file != null) {
      bloc.add(RestoreDatabaseRequested(backupPath: file.path));
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocListener<BackupRestoreBloc, BackupRestoreState>(
              listener: (context, state) {
                if (state is BackupRestoreSuccess) {
                  showSnackBar('Database saved successfully!', context);
                } else if (state is BackupRestoreFailure) {
                  showSnackBar(
                      'Failed to save database: ${state.error}', context);
                }
              },
              child: ElevatedButton.icon(
                icon: const Icon(Icons.backup),
                label: const Text('Backup Database'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: _pickBackupLocation,
              ),
            ),
            const SizedBox(height: 24),
            BlocListener<BackupRestoreBloc, BackupRestoreState>(
              listener: (context, state) {
                if (state is BackupRestoreSuccess) {
                  showSnackBar('Database restored successfully!', context);
                  context.read<QuoteBloc>().add(QuoteReloadEvent());
                  context.read<AuthorBloc>().add(AuthorLoadEvent());
                  context.read<LabelBloc>().add(LabelLoadEvent());
                  context.read<SourceBloc>().add(SourceLoadEvent());
                } else if (state is BackupRestoreFailure) {
                  showSnackBar(
                      'Failed to restore database: ${state.error}', context);
                }
              },
              child: ElevatedButton.icon(
                icon: const Icon(Icons.restore),
                label: const Text('Restore Database'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: _pickRestoreFile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
