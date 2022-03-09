import 'package:alga/l10n/l10n.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/utils/window_util.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

final currentToolProvider = StateProvider<ToolItem?>((ref) => null);

class AppScaffold extends StatelessWidget {
  final List<ToolGroup> tools;
  final ToolItem settingsItem;
  final ToolItem allToolsItem;
  AppScaffold(
      {Key? key,
      required this.tools,
      required this.settingsItem,
      required this.allToolsItem})
      : super(key: key);

  final _drawController = ScrollController();
  @override
  Widget build(BuildContext context) {
    bool isSmallDevice = MediaQuery.of(context).size.width < 980;
    final drawer = Consumer(
      builder: (context, ref, _) {
        final itemRead = ref.read(currentToolProvider.notifier);
        final item = ref.watch(currentToolProvider);
        return Drawer(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  controller: _drawController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: DrawerHeader(
                        child: Column(
                          children: const [],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ListTile(
                        leading: allToolsItem.icon,
                        title: allToolsItem.title,
                        onTap: () {
                          itemRead.state = allToolsItem;
                        },
                        tileColor: item == allToolsItem
                            ? Colors.lightBlue.withOpacity(0.1)
                            : null,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final tool = tools[index];
                          return ExpansionTile(
                            leading: tool.icon,
                            title: tool.title,
                            children: tool.items.map((e) {
                              bool same = e == item;
                              return ListTile(
                                leading: e.icon,
                                minLeadingWidth: 24,
                                title: e.title,
                                horizontalTitleGap: 4,
                                tileColor: same
                                    ? Colors.lightBlue.withOpacity(0.1)
                                    : null,
                                onTap: () {
                                  itemRead.state = e;
                                },
                              );
                            }).toList(),
                          );
                        },
                        childCount: tools.length,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(S.of(context).settings),
                onTap: () {
                  itemRead.state = settingsItem;
                },
                tileColor: item == settingsItem
                    ? Colors.lightBlue.withOpacity(0.1)
                    : null,
              ),
            ],
          ),
        );
      },
    );
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
