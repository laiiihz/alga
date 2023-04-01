import 'dart:io';
import 'package:alga/models/alga_app.dart';
import 'package:alga/models/app_type.dart';
import 'package:alga/models/icon_type.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show IconData;
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

part 'alga_app_database.g.dart';

@DataClassName('AppTag')
class AlgaAppTag extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(max: 32)();
  IntColumn get icon => integer().map(IconTypeConverter())();
}

@DataClassName('TagWithApp')
class AlgaTagWithApp extends Table {
  IntColumn get tagId => integer()();
  IntColumn get appId => integer().map(AlgaAppConverter())();
}

@DriftDatabase(tables: [AlgaAppTag, AlgaTagWithApp])
class AlgaDB extends _$AlgaDB {
  AlgaDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  List<AlgaApp> allApps() => AlgaApp.values.toList();
  Future<List<AlgaApp>> getAppsByCategoryId(int id) async {
    final state = select(algaTagWithApp);
    state.where((tbl) => tbl.appId.equals(id));
    final ids = await state.get();
    final result = <AlgaApp>[];
    for (var id in ids) {
      result.add(AlgaApp.map[id.appId] ?? AlgaApp.unknown);
    }
    return result;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
