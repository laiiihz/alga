import 'package:alga/utils/hive_adapters/theme_mode_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveUtil {
  static late Box<ThemeModeModel> themeBox;
  static init() async {
    await Hive.initFlutter('stored');
    Hive
      ..registerAdapter(ThemeModeModelAdapter())
      ..registerAdapter(ThemeModeAdapter());
    themeBox = await Hive.openBox('theme_box');
  }
}
