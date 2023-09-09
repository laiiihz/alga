import 'package:hive_flutter/hive_flutter.dart';

class HiveUtil {
  static late Box appConfigBox;
  static late Box<String> favoriteBox;
  static late Box<String> toolConfigBox;
  static init() async {
    await Hive.initFlutter('stored');
    appConfigBox = await Hive.openBox('APP_CONFIG');
    favoriteBox = await Hive.openBox<String>('FAVORITE');
    toolConfigBox = await Hive.openBox('TOOL_CONFIG');
  }
}
