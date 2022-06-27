import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/routers/app_router.dart';
import 'package:alga/utils/hive_boxes/system_box.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:alga/utils/window_util.dart';
import 'package:alga/widgets/box_builder.dart';
import 'utils/theme_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowUtil.init();
  await HiveUtil.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BoxBuilder(
        box: HiveUtil.systemBox,
        builder: (context, box) {
          final theme = ThemeUtil(Color(SystemBox.model.themeColor));
          return MaterialApp.router(
            onGenerateTitle: (context) => S.of(context).appName,
            theme: theme.getTheme(Brightness.light),
            darkTheme: theme.getTheme(Brightness.dark),
            themeMode: SystemBox.model.themeMode,
            routerDelegate: appRouter.routerDelegate,
            routeInformationProvider: appRouter.routeInformationProvider,
            routeInformationParser: appRouter.routeInformationParser,
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            locale: SystemBox.model.locale,
          );
        });
  }
}
