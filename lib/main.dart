import 'package:alga/home_view.dart';
import 'package:alga/l10n/l10n.dart';
import 'package:alga/utils/hive_boxes/theme_box.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:alga/utils/window_util.dart';
import 'package:alga/widgets/box_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late BuildContext globalContext;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowUtil.init();
  await HiveUtil.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return BoxBuilder(
        box: HiveUtil.themeBox,
        builder: (context, box) {
          return MaterialApp(
            onGenerateTitle: (context) => S.of(context).appName,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[50],
                foregroundColor: Colors.black87,
                elevation: 0,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
              ),
            ),
            themeMode: ThemeBox.themeMode.themeMode,
            home: const HomeView(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.supportedLocales,
          );
        });
  }
}
