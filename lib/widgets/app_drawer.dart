import 'package:alga/constants/import_helper.dart';
import 'package:alga/widgets/app_scaffold.dart';

final appDrawerController =
    StateProvider<ScrollController>((ref) => ScrollController());

final showAppTitle = StateProvider<bool>((ref) => true);

final _kShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
const _kDrawerShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
);

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ref.read(appDrawerController);
    _scrollController.addListener(updateScrollState);
  }

  @override
  void dispose() {
    _scrollController.removeListener(updateScrollState);
    super.dispose();
  }

  updateScrollState() {
    if (mounted && !isSmallDevice(context)) {
      ref.read(showAppTitle.notifier).state =
          ref.read(appDrawerController).offset >= 120;
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(currentToolProvider);
    final itemRead = ref.read(currentToolProvider.notifier);
    final navi = ref.watch(toolsProvider);
    final scrollController = ref.watch(appDrawerController);
    return Drawer(
      shape: _kDrawerShape,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: 120,
                  leading: const SizedBox.shrink(),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      S.of(context).appName,
                      style: TextStyle(
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  sliver: SliverToBoxAdapter(
                    child: ListTile(
                      leading: navi.allToolsItem.icon,
                      title: navi.allToolsItem.title(context),
                      shape: const StadiumBorder(),
                      onTap: () {
                        itemRead.state = navi.allToolsItem;
                        if (isSmallDevice(context)) Navigator.pop(context);
                      },
                      tileColor: item == navi.allToolsItem
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1)
                          : null,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final tool = navi.toolGroups[index];
                      return ExpansionTile(
                        initiallyExpanded: tool.items.contains(item),
                        leading: tool.icon,
                        title: tool.title(context),
                        children: tool.items.map((e) {
                          bool same = e == item;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ListTile(
                              leading: e.icon,
                              minLeadingWidth: 24,
                              title: e.title(context),
                              horizontalTitleGap: 4,
                              shape: const StadiumBorder(),
                              tileColor: same
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1)
                                  : null,
                              onTap: () {
                                itemRead.state = e;
                                if (isSmallDevice(context)) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          );
                        }).toList(),
                      );
                    },
                    childCount: navi.toolGroups.length,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(S.of(context).settings),
            onTap: () {
              itemRead.state = navi.settingsItem;
              if (isSmallDevice(context)) Navigator.pop(context);
            },
            shape: _kShape,
            tileColor: item == navi.settingsItem
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : null,
          ),
        ],
      ),
    );
  }
}
