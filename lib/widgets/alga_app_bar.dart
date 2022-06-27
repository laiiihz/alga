import 'dart:io';

import 'package:alga/widgets/alga_search_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../l10n/l10n.dart';
import '../utils/theme_util.dart';
import 'animated_show_widget.dart';
import 'app_drawer.dart';
import 'app_scaffold.dart';

class AlgaDesktopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AlgaDesktopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    Widget? drawer;
    if (isSmallDevice(context)) {
      drawer = Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          iconSize: 18,
          icon: const Icon(Icons.menu),
        );
      });
    }

    Widget appName = Consumer(
      builder: (context, ref, child) {
        final showTitle = ref.watch(showAppTitle);
        return AnimatedShowWidget(isShow: showTitle, child: child);
      },
      child: Text(
        S.of(context).appName,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary),
      ),
    );

    Widget homeButton = Consumer(
      builder: (context, ref, _) {
        final showAllTools = ref.watch(currentToolProvider) ==
            ref.watch(toolsProvider).allToolsItem;

        return AnimatedShowWidget(
          isShow: !showAllTools,
          child: IconButton(
            onPressed: () {
              ref.read(currentToolProvider.notifier).state =
                  ref.watch(toolsProvider).allToolsItem;
            },
            icon: const Icon(Icons.home_rounded),
          ),
        );
      },
    );

    if (kIsWeb) {
      if (drawer != null) children.add(drawer);
      children.add(appName);
      children.add(const Spacer());
      children.add(homeButton);
    } else if (Platform.isWindows) {
      if (drawer != null) children.add(drawer);
      children.add(appName);
      children.add(const Spacer());
      children.add(const AlgaSearchButton());
      children.add(const SizedBox(width: 8));
      children.add(homeButton);
      children.add(const _WindowsCaptionButtons());
    } else if (Platform.isMacOS) {
      children.add(const SizedBox(width: 12 * 4 + 8 * 2, height: 32));
      if (drawer != null) children.add(drawer);
      children.add(appName);
      children.add(const Spacer());
      children.add(const AlgaSearchButton());
      children.add(const SizedBox(width: 8));
      children.add(homeButton);
    }

    return DragToMoveArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  @override
  Size get preferredSize {
    if (kIsWeb || Platform.isWindows || Platform.isLinux) {
      return const Size.fromHeight(48);
    }
    if (Platform.isMacOS) {
      return const Size.fromHeight(32);
    }
    return const Size.fromHeight(48);
  }
}

class _WindowsCaptionButtons extends StatefulWidget {
  const _WindowsCaptionButtons();

  @override
  State<_WindowsCaptionButtons> createState() => __WindowsCaptionButtonsState();
}

class __WindowsCaptionButtonsState extends State<_WindowsCaptionButtons>
    with WindowListener {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WindowCaptionButton.minimize(
          brightness: Theme.of(context).brightness,
          onPressed: () async {
            bool isMinimized = await windowManager.isMinimized();
            if (isMinimized) {
              windowManager.restore();
            } else {
              windowManager.minimize();
            }
          },
        ),
        FutureBuilder<bool>(
          future: windowManager.isMaximized(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return WindowCaptionButton.unmaximize(
                brightness: Theme.of(context).brightness,
                onPressed: () {
                  windowManager.unmaximize();
                },
              );
            }
            return WindowCaptionButton.maximize(
              brightness: Theme.of(context).brightness,
              onPressed: () {
                windowManager.maximize();
              },
            );
          },
        ),
        WindowCaptionButton.close(
          brightness: Theme.of(context).brightness,
          onPressed: () {
            windowManager.close();
          },
        ),
      ],
    );
  }

  @override
  void onWindowMaximize() {
    setState(() {});
  }

  @override
  void onWindowUnmaximize() {
    setState(() {});
  }
}
