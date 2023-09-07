import 'package:alga/utils/hive_util.dart';
import 'package:hive/hive.dart';

class ToolConfig {
  const ToolConfig(this.prefix);
  final String prefix;
  static Box get box => HiveUtil.favoriteBox;

  Future write<T>(String name, T value) {
    return box.put('${prefix}_$name', value);
  }

  T read<T>(String name, T defaultValue) {
    return box.get('${prefix}_$name', defaultValue: defaultValue) as T;
  }
}
