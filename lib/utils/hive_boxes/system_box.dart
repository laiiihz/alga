import 'package:alga/utils/hive_adapters/system_settings_model.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SystemBox {
  static final Box _current = HiveUtil.systemBox;

  static SystemSettingsModel get model =>
      _current.get('default') ?? SystemSettingsModel.defaultModel;

  static set model(SystemSettingsModel state) {
    _current.put('default', state);
  }
}
