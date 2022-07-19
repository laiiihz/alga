import 'package:flutter/material.dart';

bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

bool isLight(BuildContext context) => !isDark(context);

bool isSmallDevice(BuildContext context) =>
    MediaQuery.of(context).size.width < 768;

final kDefaultLightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.lightBlue,
  brightness: Brightness.light,
);

final kDefaultDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.lightBlue,
  brightness: Brightness.dark,
);

class ThemeUtil {
  late ColorScheme colorScheme;
  ThemeUtil(this.colorScheme);

  static const _appBarTheme = AppBarTheme(elevation: 0);
  static const _inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
  );
  static final _popupMenuTheme = PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  ThemeData getTheme(Brightness brightness) {
    ColorScheme scheme = colorScheme;
    return ThemeData.from(colorScheme: scheme).copyWith(
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: scheme.background,
        foregroundColor: scheme.secondary,
      ),
      inputDecorationTheme: _inputDecorationTheme.copyWith(
        fillColor: scheme.primary.withOpacity(0.1),
        filled: true,
        contentPadding: const EdgeInsets.all(12),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.secondary,
      ),
      popupMenuTheme: _popupMenuTheme,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) return null;
          return scheme.primary;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return scheme.inversePrimary;
          } else {
            return null;
          }
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        actionTextColor: scheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      useMaterial3: true,
    );
  }
}
