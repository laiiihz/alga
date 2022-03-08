import 'package:alga/home_page.dart';
import 'package:alga/l10n/fluent_localization.dart';
import 'package:alga/l10n/l10n.dart';
import 'package:alga/utils/windows_util.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowsUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return md.Material(
      child: FluentApp(
        onGenerateTitle: (context) => S.of(context).appName,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          ZhFluentLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
      ),
    );
  }
}
