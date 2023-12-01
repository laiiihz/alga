import 'package:alga/l10n/l10n.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppConfigBox {
  static const _localeSystem = 'system';
  static const _localeChinese = 'zh';
  static const _localeEnglish = 'en';
  static const _localeJapanese = 'ja';

  static const List<String> localCodes = [
    _localeSystem,
    _localeChinese,
    _localeEnglish,
    _localeJapanese,
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
      case _localeJapanese:
        return const Locale('ja');

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

  static String? get _languageCode =>
      HiveUtil.appConfigBox.get(AppConfigType.languageCode.name);
  static set _languageCode(String? data) {
    HiveUtil.appConfigBox.put(AppConfigType.languageCode.name, data);
  }

  static String? get _countryCode =>
      HiveUtil.appConfigBox.get(AppConfigType.countryCode.name);
  static set _countryCode(String? data) {
    HiveUtil.appConfigBox.put(AppConfigType.countryCode.name, data);
  }

  static Locale? get appLocale {
    if (_languageCode == null) return null;
    return Locale(_languageCode!, _countryCode);
  }

  static set appLocale(Locale? locale) {
    if (locale == null) {
      _languageCode = null;
      _countryCode = null;
    } else {
      _languageCode = locale.languageCode;
      _countryCode = locale.countryCode;
    }
  }

  static bool get pureBlackBackground =>
      HiveUtil.appConfigBox.get(AppConfigType.pureBlackBackground.name) ??
      false;

  static set pureBlackBackground(bool state) =>
      HiveUtil.appConfigBox.put(AppConfigType.pureBlackBackground.name, state);

  static bool get useGridLayout =>
      HiveUtil.appConfigBox.get(AppConfigType.useGridLayout.name) ?? true;

  static set useGridLayout(bool state) =>
      HiveUtil.appConfigBox.put(AppConfigType.useGridLayout.name, state);
}

extension ThemeModeX on ThemeMode {
  String getName(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return context.tr.followSystem;
      case ThemeMode.light:
        return context.tr.themeLight;
      case ThemeMode.dark:
        return context.tr.themeDark;
    }
  }
}

enum AppConfigType {
  themeColor,
  themeMode,
  locale,
  languageCode,
  countryCode,
  pureBlackBackground,
  useGridLayout,
}
