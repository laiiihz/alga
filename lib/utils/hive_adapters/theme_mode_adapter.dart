import 'package:flutter/material.dart' as md;
import 'package:hive/hive.dart';

part 'theme_mode_adapter.g.dart';

@HiveType(typeId: 0)
class ThemeModeModel {
  @HiveField(0)
  final ThemeMode theThemeMode;
  md.ThemeMode get themeMode {
    switch (theThemeMode) {
      case ThemeMode.system:
        return md.ThemeMode.system;
      case ThemeMode.light:
        return md.ThemeMode.light;
      case ThemeMode.dark:
        return md.ThemeMode.dark;
    }
  }

  ThemeModeModel({
    required this.theThemeMode,
  });

  factory ThemeModeModel.fromMDMode(md.ThemeMode mode) {
    switch (mode) {
      case md.ThemeMode.system:
        return ThemeModeModel(theThemeMode: ThemeMode.system);

      case md.ThemeMode.light:
        return ThemeModeModel(theThemeMode: ThemeMode.light);

      case md.ThemeMode.dark:
        return ThemeModeModel(theThemeMode: ThemeMode.dark);
    }
  }
}

/// Describes which theme will be used by [MaterialApp].
/// copy from Material
@HiveType(typeId: 1)
enum ThemeMode {
  /// Use either the light or dark theme based on what the user has selected in
  /// the system settings.
  @HiveField(0)
  system,

  /// Always use the light mode regardless of system preference.
  @HiveField(1)
  light,

  /// Always use the dark mode (if available) regardless of system preference.
  @HiveField(2)
  dark,
}

extension ThemeModeX on ThemeMode {
  getName(md.BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }
}
