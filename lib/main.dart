import 'dart:io';

import 'package:alga/utils/hive_boxes/app_config_box.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alga/l10n/l10n.dart';
// import 'package:alga/routers/app_router.dart';
import 'package:alga/routers/app_routes.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:alga/utils/window_util.dart';
import 'package:go_router/go_router.dart';
import 'utils/theme_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveUtil.init();
  await WindowUtil.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget child = ValueListenableBuilder(
      valueListenable: AppConfigBox.keys(),
      builder: (context, _, __) {
        return DynamicColorBuilder(builder: (light, dark) {
          ColorScheme? lightScheme;
          ColorScheme? darkScheme;
          if (light != null && dark != null) {
            lightScheme = light.harmonized();
            darkScheme = dark.harmonized();
          }
          lightScheme ??= kDefaultLightColorScheme;
          darkScheme ??= kDefaultDarkColorScheme;
          return MaterialApp.router(
            routerConfig: appRouter,
            onGenerateTitle: (context) => S.of(context).appName,
            theme: ThemeUtil(lightScheme).getTheme(Brightness.light),
            darkTheme: ThemeUtil(darkScheme).getTheme(Brightness.dark),
            themeMode: AppConfigBox.themeMode,
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            locale: AppConfigBox.locale,
            debugShowCheckedModeBanner: false,
          );
        });
      },
    );

    if (Platform.isMacOS) {
      child = PlatformMenuBar(
        menus: [
          PlatformMenu(
            label: 'Alga',
            menus: [
              PlatformMenuItem(
                label: context.tr.search,
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyF,
                  meta: true,
                ),
                onSelected: () {
                  GoRouter.of(routerContext).go('/search');
                },
              ),
              PlatformMenuItem(
                label: context.tr.allApps,
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyA,
                  meta: true,
                ),
                onSelected: () {
                  GoRouter.of(routerContext).go('/apps');
                },
              ),
              PlatformMenuItem(
                label: context.tr.favorite,
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyD,
                  meta: true,
                ),
                onSelected: () {
                  GoRouter.of(routerContext).go('/favorite');
                },
              ),
              PlatformMenuItem(
                label: context.tr.settings,
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyS,
                  meta: true,
                ),
                onSelected: () {
                  GoRouter.of(routerContext).go('/settings');
                },
              ),
              const PlatformMenuItemGroup(
                members: [
                  PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.toggleFullScreen,
                  ),
                  PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.minimizeWindow,
                  ),
                  PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.zoomWindow,
                  ),
                ],
              ),
              const PlatformMenuItemGroup(
                members: [
                  PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.about,
                  ),
                  PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.quit,
                  ),
                ],
              ),
            ],
          ),
        ],
        child: child,
      );
    }

    return child;
  }
}
