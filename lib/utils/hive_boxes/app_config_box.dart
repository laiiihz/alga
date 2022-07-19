import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppConfigBox {
  static const _localeSystem = 'system';
  static const _localeChinese = 'zh';
  static const _localeEnglish = 'en';

  static const List<String> localCodes = [
    _localeSystem,
    _localeChinese,
    _localeEnglish,
  ];

  /// app theme mode
  /// * light
  /// * dark
  /// * system
  static ThemeMode get themeMode {
    int? themeValue = HiveUtil.appConfigBox.get(AppConfigType.themeMode.name);
    if (themeValue == null) return ThemeMode.system;
    if (themeValue < 0 || themeValue >= ThemeMode.values.length) {
      return ThemeMode.system;
    }
    return ThemeMode.values[themeValue];
  }

  static set themeMode(ThemeMode mode) {
    HiveUtil.appConfigBox.put(AppConfigType.themeMode.name, mode.index);
  }

  static Locale? get locale {
    switch (localeValue) {
      case _localeChinese:
        return const Locale('zh');
      case _localeEnglish:
        return const Locale('en');
      default:
        return null;
    }
  }

  static String? get localeValue {
    return HiveUtil.appConfigBox.get(AppConfigType.locale.name);
  }

  static set localeValue(String? code) {
    HiveUtil.appConfigBox.put(AppConfigType.locale.name, code);
  }

  static ValueListenable key(AppConfigType type) {
    return keys([type]);
  }

  static ValueListenable keys([List<AppConfigType>? types]) {
    List? listenKeys;
    if (types != null) {
      listenKeys = types.map((e) => e.name).toList();
    }
    return HiveUtil.appConfigBox.listenable(keys: listenKeys);
  }
}

extension ThemeModeX on ThemeMode {
  String getName(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return S.of(context).followSystem;
      case ThemeMode.light:
        return S.of(context).themeLight;
      case ThemeMode.dark:
        return S.of(context).themeDark;
    }
  }
}

enum AppConfigType {
  themeColor,
  themeMode,
  locale,
}
