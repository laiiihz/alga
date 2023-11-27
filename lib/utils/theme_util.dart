import 'package:alga/utils/hive_boxes/app_config_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_util.g.dart';

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

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() => AppConfigBox.themeMode;

  void change(ThemeMode mode) {
    state = mode;
    AppConfigBox.themeMode = mode;
  }
}

@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale? build() => AppConfigBox.appLocale;

  void change(Locale? locale) {
    AppConfigBox.appLocale = locale;
    state = locale;
  }
}

@Riverpod(keepAlive: true)
class PureBlackBackground extends _$PureBlackBackground {
  @override
  bool build() => AppConfigBox.pureBlackBackground;

  void change(bool value) {
    state = value;
    AppConfigBox.pureBlackBackground = value;
  }
}

@Riverpod(keepAlive: true)
class UseGridLayout extends _$UseGridLayout {
  @override
  bool build() => AppConfigBox.useGridLayout;

  void change(bool value) {
    state = value;
    AppConfigBox.useGridLayout = value;
  }
}

@Riverpod(keepAlive: true)
ThemeData appThemeData(
    AppThemeDataRef ref, ColorScheme colorScheme, Brightness brightness) {
  Color? scaffoldColor;
  if (brightness == Brightness.dark) {
    final isPureDark = ref.watch(pureBlackBackgroundProvider);
    if (isPureDark) scaffoldColor = Colors.black;
  }

  return ThemeData(
    colorScheme: colorScheme,
    splashFactory: InkSparkle.splashFactory,
    scaffoldBackgroundColor: scaffoldColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ).copyWith(
      contentPadding: const EdgeInsets.all(12),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: colorScheme.secondary,
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
  );
}

TextStyle getMonoTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  final typo = Typography.material2021(
      platform: defaultTargetPlatform, colorScheme: theme.colorScheme);
  final baseTextStyle = switch (theme.brightness) {
    Brightness.dark => typo.white,
    Brightness.light => typo.black,
  };
  return GoogleFonts.notoSansMonoTextTheme(baseTextStyle)
      .bodyLarge!
      .copyWith(fontSize: 12);
}
