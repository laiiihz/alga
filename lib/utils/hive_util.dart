import 'package:hive_flutter/hive_flutter.dart';

import 'package:alga/utils/hive_adapters/system_settings_model.dart';

class HiveUtil {
  static late Box<SystemSettingsModel> systemBox;
  static init() async {
    await Hive.initFlutter('stored');
    Hive.registerAdapter(SystemSettingsModelAdapter());
    systemBox = await Hive.openBox('system_box');
  }
}
