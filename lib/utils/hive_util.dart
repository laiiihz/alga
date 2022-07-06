import 'package:hive_flutter/hive_flutter.dart';

class HiveUtil {
  static late Box appConfigBox;
  static init() async {
    await Hive.initFlutter('stored');
    appConfigBox = await Hive.openBox('APP_CONFIG');
  }
}
