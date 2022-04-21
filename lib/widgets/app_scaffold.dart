import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/models/tool_items.dart';
import 'package:alga/utils/theme_util.dart';
import 'package:alga/views/search_view/search_view.dart';
import 'package:alga/widgets/animated_show_widget.dart';
import 'package:alga/widgets/app_drawer.dart';

final currentToolProvider = StateProvider<ToolItem?>((ref) {
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
          child: item?.page ?? const SizedBox.shrink(),
        );
      },
    );
    if (!isSmallDevice(context)) {
      body = Row(children: [
        drawer,
        const SizedBox(width: 8),
        Expanded(child: body),
      ]);
    }

    Widget searchButton = const SizedBox.shrink();
    if (kIsWeb || Platform.isIOS || Platform.isAndroid) {
      searchButton = IconButton(
        onPressed: () {
          showSearch(context: context, delegate: AppSearchDelegate());
        },
        icon: const Icon(Icons.search_rounded),
      );
    } else {
      searchButton = MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          showSearch(context: context, delegate: AppSearchDelegate());
        },
        shape: StadiumBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 8),
            Text(S.of(context).search),
            const SizedBox(width: 8),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(KeyModifier.alt.keyLabel,
                  style: Theme.of(context).textTheme.caption),
            ),
            const SizedBox(width: 4),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text('S', style: Theme.of(context).textTheme.caption),
            ),
          ],
        ),
      );
      searchButton = Padding(
        padding: const EdgeInsets.only(right: 46 * 3 + 16),
        child: searchButton,
      );
    }

    Widget appBarTop = Row(
      children: [
        if (isSmallDevice(context))
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          }),
        const SizedBox(width: 8),
        Consumer(
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
        ),
        Consumer(
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
        ),
        const Spacer(),
        searchButton,
      ],
    );

    if (!kIsWeb &&
        (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
      appBarTop = Stack(
        children: [
          WindowCaption(
            brightness: Theme.of(context).brightness,
            backgroundColor: Colors.transparent,
          ),
          appBarTop,
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(child: appBarTop),
        preferredSize: const Size.fromHeight(42),
      ),
      drawer: isSmallDevice(context) ? drawer : null,
      body: body,
    );
  }
}
