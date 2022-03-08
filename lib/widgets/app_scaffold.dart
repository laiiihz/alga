import 'package:alga/l10n/l10n.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/utils/window_util.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppScaffold extends StatefulWidget {
  final List<ToolGroup> tools;
  const AppScaffold({Key? key, required this.tools}) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  ToolItem? _currentItem;
  final _drawController = ScrollController();

  @override
  Widget build(BuildContext context) {
    bool isSmallDevice = MediaQuery.of(context).size.width < 980;

    final drawer = Drawer(
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _drawController,
              slivers: [
                const SliverToBoxAdapter(
                  child: DrawerHeader(
                    child: Text('Header'),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final tool = widget.tools[index];
                      return ExpansionTile(
                        leading: tool.icon,
                        title: tool.title,
                        children: tool.items.map((e) {
                          bool same = e == _currentItem;
                          return ListTile(
                            leading: e.icon,
                            minLeadingWidth: 24,
                            title: e.title,
                            horizontalTitleGap: 4,
                            tileColor:
                                same ? Colors.lightBlue.withOpacity(0.1) : null,
                            onTap: () {
                              _currentItem = e;
                              setState(() {});
                            },
                          );
                        }).toList(),
                      );
                    },
                    childCount: widget.tools.length,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(S.of(context).settings),
          ),
        ],
      ),
    );
    Widget body = PageTransitionSwitcher(
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.scaled,
          child: child,
        );
      },
      child: _currentItem?.page ?? const SizedBox.shrink(),
    );
    if (!isSmallDevice) {
      body = Row(
        children: [
          drawer,
          Expanded(
            child: body,
          ),
        ],
      );
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