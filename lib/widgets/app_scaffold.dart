import 'package:alga/l10n/l10n.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/models/tool_items.dart';
import 'package:alga/utils/window_util.dart';
import 'package:alga/widgets/app_drawer.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

final currentToolProvider = StateProvider<ToolItem?>((ref) => null);
final toolsProvider = StateProvider<NaviUtil?>((ref) => null);

class AppScaffold extends ConsumerWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSmallDevice = MediaQuery.of(context).size.width < 980;
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
    if (!isSmallDevice) {
      body = Row(children: [drawer, Expanded(child: body)]);
    }

    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Row(
            children: [
              if (isSmallDevice)
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  );
                }),
              const SizedBox(width: 8),
              Text(S.of(context).appName),
              WindowUtil.isMobileDevice
                  ? const Spacer()
                  : Expanded(
                      child: WindowCaption(
                        brightness: Theme.of(context).brightness,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
            ],
          ),
        ),
        preferredSize: const Size.fromHeight(42),
      ),
      drawer: isSmallDevice ? drawer : null,
      body: body,
    );
  }
}
