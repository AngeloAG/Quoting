import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_files/presentation/blocs/backup_restore/backup_restore_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _pickBackupLocation() async {
    String? outputFile;
    String? dir;
    try {
      dir = await getDirectoryPath(
        confirmButtonText: 'Select Folder',
      );
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
      print(e.toString());
      return;
    }
    if (!mounted) return;
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
    if (!mounted) return;
    if (outputFile != null && outputFile.isNotEmpty) {
      context
          .read<BackupRestoreBloc>()
          .add(BackupDatabaseRequested(savePath: outputFile));
    }
  }

  Future<void> _pickRestoreFile() async {
    final typeGroup = XTypeGroup(label: 'Database', extensions: ['db']);
    XFile? file;
    try {
      file = await openFile(acceptedTypeGroups: [typeGroup]);
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
    if (!mounted) return;
    if (file != null) {
      context
          .read<BackupRestoreBloc>()
          .add(RestoreDatabaseRequested(backupPath: file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.backup),
            label: const Text('Backup Database'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: _pickBackupLocation,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.restore),
            label: const Text('Restore Database'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: _pickRestoreFile,
          ),
        ],
      ),
    );
  }
}
