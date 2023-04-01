import 'package:alga/models/alga_app.dart';
import 'package:drift/drift.dart';

class AlgaAppConverter extends TypeConverter<AlgaApp, int> {
  @override
  AlgaApp fromSql(int fromDb) {
    return AlgaApp.map[fromDb] ?? AlgaApp.unknown;
  }

  @override
  int toSql(AlgaApp value) {
    return value.id;
  }
}
