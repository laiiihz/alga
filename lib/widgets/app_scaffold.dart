import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/models/tool_items.dart';
import 'package:alga/utils/window_util.dart';
import 'package:alga/views/search_view/search_view.dart';
import 'package:alga/widgets/animated_show_widget.dart';
import 'package:alga/widgets/app_drawer.dart';
import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

final currentToolProvider = StateProvider<ToolItem?>((ref) => null);
final toolsProvider = StateProvider<NaviUtil?>((ref) => null);

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

    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Row(
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
                      ref.watch(toolsProvider)!.allToolsItem;

                  return AnimatedShowWidget(
                    isShow: !showAllTools,
                    child: IconButton(
                      onPressed: () {
                        ref.read(currentToolProvider.notifier).state =
                            ref.watch(toolsProvider)!.allToolsItem;
                      },
                      icon: const Icon(Icons.home_rounded),
                    ),
                  );
                },
              ),
              WindowUtil.isMobileDevice
                  ? const Spacer()
                  : Expanded(
                      child: WindowCaption(
                        brightness: Theme.of(context).brightness,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
              if (WindowUtil.isMobileDevice)
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: AppSearchDelegate());
                  },
                  icon: const Icon(Icons.search_rounded),
                ),
            ],
          ),
        ),
        preferredSize: const Size.fromHeight(42),
      ),
      drawer: isSmallDevice(context) ? drawer : null,
      body: body,
    );
  }
}
