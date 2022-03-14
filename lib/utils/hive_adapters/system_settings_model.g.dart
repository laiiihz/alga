// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SystemSettingsModelAdapter extends TypeAdapter<SystemSettingsModel> {
  @override
  final int typeId = 1;

  @override
  SystemSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SystemSettingsModel(
      themeCode: fields[0] as int,
      localeCode: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SystemSettingsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.themeCode)
      ..writeByte(1)
      ..write(obj.localeCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
