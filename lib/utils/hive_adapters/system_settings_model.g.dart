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
      themeCode: fields[0] == null ? 0 : fields[0] as int,
      localeCode: fields[1] == null ? 'system' : fields[1] as String,
      themeColor: fields[2] == null ? 4280391411 : fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SystemSettingsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.themeCode)
      ..writeByte(1)
      ..write(obj.localeCode)
      ..writeByte(2)
      ..write(obj.themeColor);
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
