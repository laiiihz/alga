import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  static final _inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  ThemeData getTheme(Brightness brightness) {
    ColorScheme scheme = colorScheme;
    final typo = Typography.material2021(
        platform: defaultTargetPlatform, colorScheme: colorScheme);
    final baseTextStyle = switch (brightness) {
      Brightness.dark => typo.white,
      Brightness.light => typo.black,
    };
    return ThemeData(
      colorScheme: colorScheme,
      splashFactory: InkSparkle.splashFactory,
      inputDecorationTheme: _inputDecorationTheme.copyWith(
        contentPadding: const EdgeInsets.all(12),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.secondary,
      ),
      snackBarTheme: SnackBarThemeData(
        actionTextColor: scheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.notoSansMonoTextTheme(baseTextStyle)
            .bodyLarge
            ?.copyWith(fontSize: 12),
      ),
      useMaterial3: true,
    );
  }
}
