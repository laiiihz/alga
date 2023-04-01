import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class IconTypeConverter extends TypeConverter<IconData, int> {
  @override
  IconData fromSql(int fromDb) {
    return IconData(fromDb, fontFamily: 'MaterialIcons');
  }

  @override
  int toSql(IconData value) {
    return value.codePoint;
  }
}
