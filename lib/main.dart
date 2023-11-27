import 'dart:io';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/routers/app_router.dart';
import 'package:alga/ui/alga_view/all_apps/alga_app_view.dart';
import 'package:alga/ui/views/favorite_view.dart';
import 'package:alga/ui/views/search_view.dart';
import 'package:alga/ui/views/settings_view.dart';
import 'package:alga/utils/hive_boxes/app_config_box.dart';
import 'package:alga/utils/services/app_service.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/theme_util.dart';

void main() async {
  await AppService().run();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget child = ValueListenableBuilder(
      valueListenable: AppConfigBox.keys(),
      builder: (context, _, __) {
        return DynamicColorBuilder(builder: (light, dark) {
          light = light?.harmonized() ?? kDefaultLightColorScheme;
          dark = dark?.harmonized() ?? kDefaultDarkColorScheme;
          return MaterialApp.router(
            routerConfig: ref.watch(appRouterProvider),
            onGenerateTitle: (context) => S.of(context).appName,
            theme: ref.watch(appThemeDataProvider(light, Brightness.light)),
            darkTheme: ref.watch(appThemeDataProvider(dark, Brightness.dark)),
            themeMode: ref.watch(appThemeModeProvider),
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
                  SearchRoute().go(routerContext);
                },
              ),
              PlatformMenuItem(
                label: context.tr.allApps,
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyA,
                  meta: true,
                ),
                onSelected: () {
                  AppsRoute().go(routerContext);
                },
              ),
              PlatformMenuItem(
                label: context.tr.favorite,
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyD,
                  meta: true,
                ),
                onSelected: () {
                  FavoriteRoute().go(routerContext);
                },
              ),
              PlatformMenuItem(
                label: context.tr.settings,
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyS,
                  meta: true,
                ),
                onSelected: () {
                  SettingsRoute().go(routerContext);
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
