import 'package:drift/drift.dart';

class Labels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().withLength(min: 3, max: 32)();
}
