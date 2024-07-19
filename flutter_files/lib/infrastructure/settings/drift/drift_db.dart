import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_files/infrastructure/settings/drift/tables.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift_db.g.dart';

@DriftDatabase(tables: [Labels, Authors, Sources, Quotes])
class DriftDB extends _$DriftDB {
  DriftDB() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) async {
      await m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(authors);
        await m.createTable(sources);
      }
      if (from < 3) {
        await m.createTable(quotes);
      }
      if (from < 4) {
        await customStatement('''
            CREATE VIRTUAL TABLE fts_quotes USING fts5(
              content, 
              details, 
              author_name, 
              label_content, 
              source_content
            );
            ''');

        await customStatement('''
            CREATE TRIGGER quotes_insert AFTER INSERT ON quotes
            BEGIN
              INSERT INTO fts_quotes (
                rowid, 
                content, 
                details, 
                author_name, 
                label_content, 
                source_content
              )
              SELECT 
                new.id, 
                new.content, 
                new.details, 
                (SELECT name FROM authors WHERE id = new.author_id), 
                (SELECT content FROM labels WHERE id = new.label_id), 
                (SELECT content FROM sources WHERE id = new.source_id);
            END;
            ''');

        await customStatement('''
            CREATE TRIGGER quotes_update AFTER UPDATE ON quotes
            BEGIN
              UPDATE fts_quotes SET 
                content = new.content, 
                details = new.details, 
                author_name = (SELECT name FROM authors WHERE id = new.author_id), 
                label_content = (SELECT content FROM labels WHERE id = new.label_id), 
                source_content = (SELECT content FROM sources WHERE id = new.source_id)
              WHERE rowid = old.id;
            END;
            ''');

        await customStatement('''
            CREATE TRIGGER quotes_delete AFTER DELETE ON quotes
            BEGIN
              DELETE FROM fts_quotes WHERE rowid = old.id;
            END;
            ''');

        // Create triggers for related tables
        await customStatement('''
            CREATE TRIGGER authors_update AFTER UPDATE ON authors
            BEGIN
              UPDATE fts_quotes SET 
                author_name = new.name
              WHERE author_name = old.name;
            END;
            ''');

        await customStatement('''
            CREATE TRIGGER labels_update AFTER UPDATE ON labels
            BEGIN
              UPDATE fts_quotes SET 
                label_content = new.content
              WHERE label_content = old.content;
            END;
            ''');

        await customStatement('''
            CREATE TRIGGER sources_update AFTER UPDATE ON sources
            BEGIN
              UPDATE fts_quotes SET 
                source_content = new.content
              WHERE source_content = old.content;
            END;
            ''');
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
