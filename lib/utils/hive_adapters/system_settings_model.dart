import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:alga/l10n/l10n.dart';

part 'system_settings_model.g.dart';

const _kDefaultColor = 0xFF2196F3;

@HiveType(typeId: 1)
class SystemSettingsModel {
  static const themeSystem = 0;
  static const themeLight = 1;
  static const themeDark = 2;
  static const String localSystem = 'system';
  static const String localChinese = 'zh';
  static const String localEnglish = 'en';

  static const List<String> localCodes = [
    localSystem,
    localChinese,
    localEnglish,
  ];
  @HiveField(0, defaultValue: themeSystem)
  final int themeCode;
  @HiveField(1, defaultValue: localSystem)
  final String localeCode;
  @HiveField(2, defaultValue: _kDefaultColor)
  final int themeColor;
  const SystemSettingsModel({
    required this.themeCode,
    required this.localeCode,
    required this.themeColor,
  });

  ThemeMode get themeMode {
    switch (themeCode) {
      case themeSystem:
        return ThemeMode.system;
      case themeLight:
        return ThemeMode.light;
      case themeDark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Locale? get locale {
    switch (localeCode) {
      case localSystem:
        return null;
      case localChinese:
        return const Locale(localChinese);
      case localEnglish:
        return const Locale(localEnglish);
      default:
        return null;
    }
  }

  static const SystemSettingsModel defaultModel = SystemSettingsModel(
    themeCode: themeSystem,
    localeCode: localSystem,
    themeColor: _kDefaultColor,
  );

  SystemSettingsModel copyWith({
    ThemeMode? themeMode,
    String? localeCode,
    Color? color,
  }) {
    return SystemSettingsModel(
      themeCode: themeMode?.code ?? themeCode,
      localeCode: localeCode ?? this.localeCode,
      themeColor: color?.value ?? themeColor,
    );
  }
}

extension ThemeModeX on ThemeMode {
  getName(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return S.of(context).followSystem;
      case ThemeMode.light:
        return S.of(context).themeLight;
      case ThemeMode.dark:
        return S.of(context).themeDark;
    }
  }

  int get code {
    switch (this) {
      case ThemeMode.system:
        return SystemSettingsModel.themeSystem;
      case ThemeMode.light:
        return SystemSettingsModel.themeLight;
      case ThemeMode.dark:
        return SystemSettingsModel.themeDark;
    }
  }
}
