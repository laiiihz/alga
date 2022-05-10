import 'dart:io';

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
  const AppScaffold({Key? key}) : super(key: key);

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
    if (!isSmallDevice(context)) {
      body = Row(children: [
        drawer,
        const SizedBox(width: 16),
        Expanded(child: body),
      ]);
    }

    return Scaffold(
      appBar: Platform.isAndroid || Platform.isIOS
          ? null
          : const AlgaDesktopAppBar(),
      drawer: isSmallDevice(context) ? drawer : null,
      body: body,
    );
  }
}
