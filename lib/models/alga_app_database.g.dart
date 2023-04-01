// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alga_app_database.dart';

// ignore_for_file: type=lint
class $AlgaAppTagTable extends AlgaAppTag
    with TableInfo<$AlgaAppTagTable, AppTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlgaAppTagTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumnWithTypeConverter<IconData, int> icon =
      GeneratedColumn<int>('icon', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<IconData>($AlgaAppTagTable.$convertericon);
  @override
  List<GeneratedColumn> get $columns => [id, title, icon];
  @override
  String get aliasedName => _alias ?? 'alga_app_tag';
  @override
  String get actualTableName => 'alga_app_tag';
  @override
  VerificationContext validateIntegrity(Insertable<AppTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    context.handle(_iconMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppTag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      icon: $AlgaAppTagTable.$convertericon.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon'])!),
    );
  }

  @override
  $AlgaAppTagTable createAlias(String alias) {
    return $AlgaAppTagTable(attachedDatabase, alias);
  }

  static TypeConverter<IconData, int> $convertericon = IconTypeConverter();
}

class AppTag extends DataClass implements Insertable<AppTag> {
  final int id;
  final String title;
  final IconData icon;
  const AppTag({required this.id, required this.title, required this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    {
      final converter = $AlgaAppTagTable.$convertericon;
      map['icon'] = Variable<int>(converter.toSql(icon));
    }
    return map;
  }

  AlgaAppTagCompanion toCompanion(bool nullToAbsent) {
    return AlgaAppTagCompanion(
      id: Value(id),
      title: Value(title),
      icon: Value(icon),
    );
  }

  factory AppTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppTag(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      icon: serializer.fromJson<IconData>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'icon': serializer.toJson<IconData>(icon),
    };
  }

  AppTag copyWith({int? id, String? title, IconData? icon}) => AppTag(
        id: id ?? this.id,
        title: title ?? this.title,
        icon: icon ?? this.icon,
      );
  @override
  String toString() {
    return (StringBuffer('AppTag(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppTag &&
          other.id == this.id &&
          other.title == this.title &&
          other.icon == this.icon);
}

class AlgaAppTagCompanion extends UpdateCompanion<AppTag> {
  final Value<int> id;
  final Value<String> title;
  final Value<IconData> icon;
  const AlgaAppTagCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.icon = const Value.absent(),
  });
  AlgaAppTagCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required IconData icon,
  })  : title = Value(title),
        icon = Value(icon);
  static Insertable<AppTag> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? icon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (icon != null) 'icon': icon,
    });
  }

  AlgaAppTagCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<IconData>? icon}) {
    return AlgaAppTagCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (icon.present) {
      final converter = $AlgaAppTagTable.$convertericon;
      map['icon'] = Variable<int>(converter.toSql(icon.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlgaAppTagCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }
}

class $AlgaTagWithAppTable extends AlgaTagWithApp
    with TableInfo<$AlgaTagWithAppTable, TagWithApp> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlgaTagWithAppTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _appIdMeta = const VerificationMeta('appId');
  @override
  late final GeneratedColumnWithTypeConverter<AlgaApp, int> appId =
      GeneratedColumn<int>('app_id', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<AlgaApp>($AlgaTagWithAppTable.$converterappId);
  @override
  List<GeneratedColumn> get $columns => [tagId, appId];
  @override
  String get aliasedName => _alias ?? 'alga_tag_with_app';
  @override
  String get actualTableName => 'alga_tag_with_app';
  @override
  VerificationContext validateIntegrity(Insertable<TagWithApp> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    context.handle(_appIdMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TagWithApp map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagWithApp(
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      appId: $AlgaTagWithAppTable.$converterappId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}app_id'])!),
    );
  }

  @override
  $AlgaTagWithAppTable createAlias(String alias) {
    return $AlgaTagWithAppTable(attachedDatabase, alias);
  }

  static TypeConverter<AlgaApp, int> $converterappId = AlgaAppConverter();
}

class TagWithApp extends DataClass implements Insertable<TagWithApp> {
  final int tagId;
  final AlgaApp appId;
  const TagWithApp({required this.tagId, required this.appId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tag_id'] = Variable<int>(tagId);
    {
      final converter = $AlgaTagWithAppTable.$converterappId;
      map['app_id'] = Variable<int>(converter.toSql(appId));
    }
    return map;
  }

  AlgaTagWithAppCompanion toCompanion(bool nullToAbsent) {
    return AlgaTagWithAppCompanion(
      tagId: Value(tagId),
      appId: Value(appId),
    );
  }

  factory TagWithApp.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagWithApp(
      tagId: serializer.fromJson<int>(json['tagId']),
      appId: serializer.fromJson<AlgaApp>(json['appId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagId': serializer.toJson<int>(tagId),
      'appId': serializer.toJson<AlgaApp>(appId),
    };
  }

  TagWithApp copyWith({int? tagId, AlgaApp? appId}) => TagWithApp(
        tagId: tagId ?? this.tagId,
        appId: appId ?? this.appId,
      );
  @override
  String toString() {
    return (StringBuffer('TagWithApp(')
          ..write('tagId: $tagId, ')
          ..write('appId: $appId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tagId, appId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagWithApp &&
          other.tagId == this.tagId &&
          other.appId == this.appId);
}

class AlgaTagWithAppCompanion extends UpdateCompanion<TagWithApp> {
  final Value<int> tagId;
  final Value<AlgaApp> appId;
  const AlgaTagWithAppCompanion({
    this.tagId = const Value.absent(),
    this.appId = const Value.absent(),
  });
  AlgaTagWithAppCompanion.insert({
    required int tagId,
    required AlgaApp appId,
  })  : tagId = Value(tagId),
        appId = Value(appId);
  static Insertable<TagWithApp> custom({
    Expression<int>? tagId,
    Expression<int>? appId,
  }) {
    return RawValuesInsertable({
      if (tagId != null) 'tag_id': tagId,
      if (appId != null) 'app_id': appId,
    });
  }

  AlgaTagWithAppCompanion copyWith({Value<int>? tagId, Value<AlgaApp>? appId}) {
    return AlgaTagWithAppCompanion(
      tagId: tagId ?? this.tagId,
      appId: appId ?? this.appId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (appId.present) {
      final converter = $AlgaTagWithAppTable.$converterappId;
      map['app_id'] = Variable<int>(converter.toSql(appId.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlgaTagWithAppCompanion(')
          ..write('tagId: $tagId, ')
          ..write('appId: $appId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AlgaDB extends GeneratedDatabase {
  _$AlgaDB(QueryExecutor e) : super(e);
  late final $AlgaAppTagTable algaAppTag = $AlgaAppTagTable(this);
  late final $AlgaTagWithAppTable algaTagWithApp = $AlgaTagWithAppTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [algaAppTag, algaTagWithApp];
}
