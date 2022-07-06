import 'dart:io';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/widgets/alga_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alga/models/tool_item.dart';
import 'package:alga/models/tool_items.dart';
import 'package:alga/utils/theme_util.dart';
import 'package:alga/widgets/app_drawer.dart';

final currentToolProvider = StateProvider<ToolItem>((ref) {
  return ref.watch(toolsProvider).allToolsItem;
});
final toolsProvider = StateProvider<NaviUtil>((ref) => NaviUtil());

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    const drawer = AppDrawer();
    Widget body = Consumer(
      builder: (context, ref, child) {
        final item = ref.watch(currentToolProvider);
        return PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
              child: child,
            );
          },
          child: item.page,
        );
      },
    );

    Widget? bottomBar;
    if (!isSmallDevice(context)) {
      body = Row(children: [
        drawer,
        const SizedBox(width: 16),
        Expanded(child: body),
      ]);
    } else {
      bottomBar = Consumer(
        builder: (context, ref, child) {
          final navi = ref.watch(toolsProvider);
          final item = ref.watch(currentToolProvider);
          int selectedIndex = 0;
          if (item == navi.settingsItem) {
            selectedIndex = 1;
          } else if (item == navi.allToolsItem) {
            selectedIndex = 0;
          } else {
            selectedIndex = 0;
          }
          return NavigationBar(
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  ref.watch(currentToolProvider.state).state =
                      navi.allToolsItem;
                  break;
                default:
                  ref.watch(currentToolProvider.state).state =
                      navi.settingsItem;
                  break;
              }
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.category_outlined),
                selectedIcon: const Icon(Icons.category),
                label: S.of(context).allTools,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: S.of(context).settings,
              ),
            ],
            selectedIndex: selectedIndex,
          );
        },
      );
    }

    return Scaffold(
      appBar: Platform.isAndroid || Platform.isIOS
          ? null
          : const AlgaDesktopAppBar(),
      drawer: isSmallDevice(context) ? drawer : null,
      body: body,
      bottomNavigationBar: bottomBar,
    );
  }
}
