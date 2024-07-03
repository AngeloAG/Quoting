import 'package:drift/drift.dart';

class Labels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().withLength(min: 3, max: 32)();
}

class Authors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 3, max: 32)();
}

class Sources extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().withLength(min: 3, max: 32)();
}

class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get authorId => integer().nullable().references(Authors, #id)();
  IntColumn get labelId => integer().nullable().references(Labels, #id)();
  IntColumn get sourceId => integer().nullable().references(Sources, #id)();
  TextColumn get details => text()();
  TextColumn get content => text().withLength(min: 2, max: 2000)();
}
