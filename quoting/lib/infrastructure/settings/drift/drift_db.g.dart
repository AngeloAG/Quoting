// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_db.dart';

// ignore_for_file: type=lint
class FtsQuotes extends Table
    with TableInfo<FtsQuotes, FtsQuote>, VirtualTableInfo<FtsQuotes, FtsQuote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  FtsQuotes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  static const VerificationMeta _authorNameMeta =
      const VerificationMeta('authorName');
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
      'author_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  static const VerificationMeta _labelContentMeta =
      const VerificationMeta('labelContent');
  late final GeneratedColumn<String> labelContent = GeneratedColumn<String>(
      'label_content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  static const VerificationMeta _sourceContentMeta =
      const VerificationMeta('sourceContent');
  late final GeneratedColumn<String> sourceContent = GeneratedColumn<String>(
      'source_content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [content, details, authorName, labelContent, sourceContent];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fts_quotes';
  @override
  VerificationContext validateIntegrity(Insertable<FtsQuote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('label_content')) {
      context.handle(
          _labelContentMeta,
          labelContent.isAcceptableOrUnknown(
              data['label_content']!, _labelContentMeta));
    } else if (isInserting) {
      context.missing(_labelContentMeta);
    }
    if (data.containsKey('source_content')) {
      context.handle(
          _sourceContentMeta,
          sourceContent.isAcceptableOrUnknown(
              data['source_content']!, _sourceContentMeta));
    } else if (isInserting) {
      context.missing(_sourceContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FtsQuote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FtsQuote(
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details'])!,
      authorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_name'])!,
      labelContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label_content'])!,
      sourceContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_content'])!,
    );
  }

  @override
  FtsQuotes createAlias(String alias) {
    return FtsQuotes(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs =>
      'fts5(content, details, author_name, label_content, source_content)';
}

class FtsQuote extends DataClass implements Insertable<FtsQuote> {
  final String content;
  final String details;
  final String authorName;
  final String labelContent;
  final String sourceContent;
  const FtsQuote(
      {required this.content,
      required this.details,
      required this.authorName,
      required this.labelContent,
      required this.sourceContent});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content'] = Variable<String>(content);
    map['details'] = Variable<String>(details);
    map['author_name'] = Variable<String>(authorName);
    map['label_content'] = Variable<String>(labelContent);
    map['source_content'] = Variable<String>(sourceContent);
    return map;
  }

  FtsQuotesCompanion toCompanion(bool nullToAbsent) {
    return FtsQuotesCompanion(
      content: Value(content),
      details: Value(details),
      authorName: Value(authorName),
      labelContent: Value(labelContent),
      sourceContent: Value(sourceContent),
    );
  }

  factory FtsQuote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FtsQuote(
      content: serializer.fromJson<String>(json['content']),
      details: serializer.fromJson<String>(json['details']),
      authorName: serializer.fromJson<String>(json['author_name']),
      labelContent: serializer.fromJson<String>(json['label_content']),
      sourceContent: serializer.fromJson<String>(json['source_content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String>(content),
      'details': serializer.toJson<String>(details),
      'author_name': serializer.toJson<String>(authorName),
      'label_content': serializer.toJson<String>(labelContent),
      'source_content': serializer.toJson<String>(sourceContent),
    };
  }

  FtsQuote copyWith(
          {String? content,
          String? details,
          String? authorName,
          String? labelContent,
          String? sourceContent}) =>
      FtsQuote(
        content: content ?? this.content,
        details: details ?? this.details,
        authorName: authorName ?? this.authorName,
        labelContent: labelContent ?? this.labelContent,
        sourceContent: sourceContent ?? this.sourceContent,
      );
  @override
  String toString() {
    return (StringBuffer('FtsQuote(')
          ..write('content: $content, ')
          ..write('details: $details, ')
          ..write('authorName: $authorName, ')
          ..write('labelContent: $labelContent, ')
          ..write('sourceContent: $sourceContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(content, details, authorName, labelContent, sourceContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FtsQuote &&
          other.content == this.content &&
          other.details == this.details &&
          other.authorName == this.authorName &&
          other.labelContent == this.labelContent &&
          other.sourceContent == this.sourceContent);
}

class FtsQuotesCompanion extends UpdateCompanion<FtsQuote> {
  final Value<String> content;
  final Value<String> details;
  final Value<String> authorName;
  final Value<String> labelContent;
  final Value<String> sourceContent;
  final Value<int> rowid;
  const FtsQuotesCompanion({
    this.content = const Value.absent(),
    this.details = const Value.absent(),
    this.authorName = const Value.absent(),
    this.labelContent = const Value.absent(),
    this.sourceContent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FtsQuotesCompanion.insert({
    required String content,
    required String details,
    required String authorName,
    required String labelContent,
    required String sourceContent,
    this.rowid = const Value.absent(),
  })  : content = Value(content),
        details = Value(details),
        authorName = Value(authorName),
        labelContent = Value(labelContent),
        sourceContent = Value(sourceContent);
  static Insertable<FtsQuote> custom({
    Expression<String>? content,
    Expression<String>? details,
    Expression<String>? authorName,
    Expression<String>? labelContent,
    Expression<String>? sourceContent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (content != null) 'content': content,
      if (details != null) 'details': details,
      if (authorName != null) 'author_name': authorName,
      if (labelContent != null) 'label_content': labelContent,
      if (sourceContent != null) 'source_content': sourceContent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FtsQuotesCompanion copyWith(
      {Value<String>? content,
      Value<String>? details,
      Value<String>? authorName,
      Value<String>? labelContent,
      Value<String>? sourceContent,
      Value<int>? rowid}) {
    return FtsQuotesCompanion(
      content: content ?? this.content,
      details: details ?? this.details,
      authorName: authorName ?? this.authorName,
      labelContent: labelContent ?? this.labelContent,
      sourceContent: sourceContent ?? this.sourceContent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (labelContent.present) {
      map['label_content'] = Variable<String>(labelContent.value);
    }
    if (sourceContent.present) {
      map['source_content'] = Variable<String>(sourceContent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FtsQuotesCompanion(')
          ..write('content: $content, ')
          ..write('details: $details, ')
          ..write('authorName: $authorName, ')
          ..write('labelContent: $labelContent, ')
          ..write('sourceContent: $sourceContent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuthorsTable extends Authors with TableInfo<$AuthorsTable, Author> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'authors';
  @override
  VerificationContext validateIntegrity(Insertable<Author> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Author map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Author(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $AuthorsTable createAlias(String alias) {
    return $AuthorsTable(attachedDatabase, alias);
  }
}

class Author extends DataClass implements Insertable<Author> {
  final int id;
  final String name;
  const Author({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AuthorsCompanion toCompanion(bool nullToAbsent) {
    return AuthorsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Author.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Author(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Author copyWith({int? id, String? name}) => Author(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Author(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Author && other.id == this.id && other.name == this.name);
}

class AuthorsCompanion extends UpdateCompanion<Author> {
  final Value<int> id;
  final Value<String> name;
  const AuthorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  AuthorsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Author> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  AuthorsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return AuthorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $LabelsTable extends Labels with TableInfo<$LabelsTable, Label> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'labels';
  @override
  VerificationContext validateIntegrity(Insertable<Label> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Label map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Label(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $LabelsTable createAlias(String alias) {
    return $LabelsTable(attachedDatabase, alias);
  }
}

class Label extends DataClass implements Insertable<Label> {
  final int id;
  final String content;
  const Label({required this.id, required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    return map;
  }

  LabelsCompanion toCompanion(bool nullToAbsent) {
    return LabelsCompanion(
      id: Value(id),
      content: Value(content),
    );
  }

  factory Label.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Label(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
    };
  }

  Label copyWith({int? id, String? content}) => Label(
        id: id ?? this.id,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('Label(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Label && other.id == this.id && other.content == this.content);
}

class LabelsCompanion extends UpdateCompanion<Label> {
  final Value<int> id;
  final Value<String> content;
  const LabelsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
  });
  LabelsCompanion.insert({
    this.id = const Value.absent(),
    required String content,
  }) : content = Value(content);
  static Insertable<Label> custom({
    Expression<int>? id,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
    });
  }

  LabelsCompanion copyWith({Value<int>? id, Value<String>? content}) {
    return LabelsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabelsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $SourcesTable extends Sources with TableInfo<$SourcesTable, Source> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sources';
  @override
  VerificationContext validateIntegrity(Insertable<Source> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Source map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Source(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $SourcesTable createAlias(String alias) {
    return $SourcesTable(attachedDatabase, alias);
  }
}

class Source extends DataClass implements Insertable<Source> {
  final int id;
  final String content;
  const Source({required this.id, required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    return map;
  }

  SourcesCompanion toCompanion(bool nullToAbsent) {
    return SourcesCompanion(
      id: Value(id),
      content: Value(content),
    );
  }

  factory Source.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Source(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
    };
  }

  Source copyWith({int? id, String? content}) => Source(
        id: id ?? this.id,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('Source(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Source && other.id == this.id && other.content == this.content);
}

class SourcesCompanion extends UpdateCompanion<Source> {
  final Value<int> id;
  final Value<String> content;
  const SourcesCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
  });
  SourcesCompanion.insert({
    this.id = const Value.absent(),
    required String content,
  }) : content = Value(content);
  static Insertable<Source> custom({
    Expression<int>? id,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
    });
  }

  SourcesCompanion copyWith({Value<int>? id, Value<String>? content}) {
    return SourcesCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SourcesCompanion(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, Quote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  @override
  late final GeneratedColumn<int> authorId = GeneratedColumn<int>(
      'author_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES authors (id)'));
  static const VerificationMeta _labelIdMeta =
      const VerificationMeta('labelId');
  @override
  late final GeneratedColumn<int> labelId = GeneratedColumn<int>(
      'label_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES labels (id)'));
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
      'source_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sources (id)'));
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 2, maxTextLength: 2000),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, authorId, labelId, sourceId, details, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(Insertable<Quote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    }
    if (data.containsKey('label_id')) {
      context.handle(_labelIdMeta,
          labelId.isAcceptableOrUnknown(data['label_id']!, _labelIdMeta));
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}author_id']),
      labelId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}label_id']),
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_id']),
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }
}

class Quote extends DataClass implements Insertable<Quote> {
  final int id;
  final int? authorId;
  final int? labelId;
  final int? sourceId;
  final String details;
  final String content;
  const Quote(
      {required this.id,
      this.authorId,
      this.labelId,
      this.sourceId,
      required this.details,
      required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<int>(authorId);
    }
    if (!nullToAbsent || labelId != null) {
      map['label_id'] = Variable<int>(labelId);
    }
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<int>(sourceId);
    }
    map['details'] = Variable<String>(details);
    map['content'] = Variable<String>(content);
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
      labelId: labelId == null && nullToAbsent
          ? const Value.absent()
          : Value(labelId),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      details: Value(details),
      content: Value(content),
    );
  }

  factory Quote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quote(
      id: serializer.fromJson<int>(json['id']),
      authorId: serializer.fromJson<int?>(json['authorId']),
      labelId: serializer.fromJson<int?>(json['labelId']),
      sourceId: serializer.fromJson<int?>(json['sourceId']),
      details: serializer.fromJson<String>(json['details']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'authorId': serializer.toJson<int?>(authorId),
      'labelId': serializer.toJson<int?>(labelId),
      'sourceId': serializer.toJson<int?>(sourceId),
      'details': serializer.toJson<String>(details),
      'content': serializer.toJson<String>(content),
    };
  }

  Quote copyWith(
          {int? id,
          Value<int?> authorId = const Value.absent(),
          Value<int?> labelId = const Value.absent(),
          Value<int?> sourceId = const Value.absent(),
          String? details,
          String? content}) =>
      Quote(
        id: id ?? this.id,
        authorId: authorId.present ? authorId.value : this.authorId,
        labelId: labelId.present ? labelId.value : this.labelId,
        sourceId: sourceId.present ? sourceId.value : this.sourceId,
        details: details ?? this.details,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('Quote(')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('labelId: $labelId, ')
          ..write('sourceId: $sourceId, ')
          ..write('details: $details, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, authorId, labelId, sourceId, details, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quote &&
          other.id == this.id &&
          other.authorId == this.authorId &&
          other.labelId == this.labelId &&
          other.sourceId == this.sourceId &&
          other.details == this.details &&
          other.content == this.content);
}

class QuotesCompanion extends UpdateCompanion<Quote> {
  final Value<int> id;
  final Value<int?> authorId;
  final Value<int?> labelId;
  final Value<int?> sourceId;
  final Value<String> details;
  final Value<String> content;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.authorId = const Value.absent(),
    this.labelId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.details = const Value.absent(),
    this.content = const Value.absent(),
  });
  QuotesCompanion.insert({
    this.id = const Value.absent(),
    this.authorId = const Value.absent(),
    this.labelId = const Value.absent(),
    this.sourceId = const Value.absent(),
    required String details,
    required String content,
  })  : details = Value(details),
        content = Value(content);
  static Insertable<Quote> custom({
    Expression<int>? id,
    Expression<int>? authorId,
    Expression<int>? labelId,
    Expression<int>? sourceId,
    Expression<String>? details,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (authorId != null) 'author_id': authorId,
      if (labelId != null) 'label_id': labelId,
      if (sourceId != null) 'source_id': sourceId,
      if (details != null) 'details': details,
      if (content != null) 'content': content,
    });
  }

  QuotesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? authorId,
      Value<int?>? labelId,
      Value<int?>? sourceId,
      Value<String>? details,
      Value<String>? content}) {
    return QuotesCompanion(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      labelId: labelId ?? this.labelId,
      sourceId: sourceId ?? this.sourceId,
      details: details ?? this.details,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<int>(authorId.value);
    }
    if (labelId.present) {
      map['label_id'] = Variable<int>(labelId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotesCompanion(')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('labelId: $labelId, ')
          ..write('sourceId: $sourceId, ')
          ..write('details: $details, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftDB extends GeneratedDatabase {
  _$DriftDB(QueryExecutor e) : super(e);
  late final FtsQuotes ftsQuotes = FtsQuotes(this);
  late final $AuthorsTable authors = $AuthorsTable(this);
  late final $LabelsTable labels = $LabelsTable(this);
  late final $SourcesTable sources = $SourcesTable(this);
  late final $QuotesTable quotes = $QuotesTable(this);
  late final Trigger quotesInsert = Trigger(
      'CREATE TRIGGER quotes_insert AFTER INSERT ON quotes BEGIN INSERT INTO fts_quotes ("rowid", content, details, author_name, label_content, source_content) SELECT new.id, new.content, new.details, (SELECT name FROM authors WHERE id = new.author_id), (SELECT content FROM labels WHERE id = new.label_id), (SELECT content FROM sources WHERE id = new.source_id);END',
      'quotes_insert');
  late final Trigger quotesUpdate = Trigger(
      'CREATE TRIGGER quotes_update AFTER UPDATE ON quotes BEGIN UPDATE fts_quotes SET content = new.content, details = new.details, author_name = (SELECT name FROM authors WHERE id = new.author_id), label_content = (SELECT content FROM labels WHERE id = new.label_id), source_content = (SELECT content FROM sources WHERE id = new.source_id) WHERE "rowid" = old.id;END',
      'quotes_update');
  late final Trigger quotesDelete = Trigger(
      'CREATE TRIGGER quotes_delete AFTER DELETE ON quotes BEGIN DELETE FROM fts_quotes WHERE "rowid" = old.id;END',
      'quotes_delete');
  late final Trigger authorsUpdate = Trigger(
      'CREATE TRIGGER authors_update AFTER UPDATE ON authors BEGIN UPDATE fts_quotes SET author_name = new.name WHERE author_name = old.name;END',
      'authors_update');
  late final Trigger labelsUpdate = Trigger(
      'CREATE TRIGGER labels_update AFTER UPDATE ON labels BEGIN UPDATE fts_quotes SET label_content = new.content WHERE label_content = old.content;END',
      'labels_update');
  late final Trigger sourcesUpdate = Trigger(
      'CREATE TRIGGER sources_update AFTER UPDATE ON sources BEGIN UPDATE fts_quotes SET source_content = new.content WHERE source_content = old.content;END',
      'sources_update');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        ftsQuotes,
        authors,
        labels,
        sources,
        quotes,
        quotesInsert,
        quotesUpdate,
        quotesDelete,
        authorsUpdate,
        labelsUpdate,
        sourcesUpdate
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('quotes',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('fts_quotes', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('quotes',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('fts_quotes', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('quotes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('fts_quotes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('authors',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('fts_quotes', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('labels',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('fts_quotes', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('sources',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('fts_quotes', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}
