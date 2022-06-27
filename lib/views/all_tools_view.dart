import 'package:alga/constants/import_helper.dart';
import 'package:alga/widgets/app_scaffold.dart';

class AllToolsView extends ConsumerStatefulWidget {
  const AllToolsView({super.key});

  @override
  ConsumerState<AllToolsView> createState() => _AllToolsViewState();
}

class _AllToolsViewState extends ConsumerState<AllToolsView> {
  @override
  Widget build(BuildContext context) {
    final itemRead = ref.read(currentToolProvider.notifier);
    final navi = ref.watch(toolsProvider);
    return ToolView(
      title: Text(S.of(context).allTools),
      content: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final item = navi.items[index];
          return Material(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                itemRead.state = item;
              },
              child: Stack(
                children: [
                  Align(
                    alignment: const Alignment(0, -0.4),
                    child: IconTheme(
                      data: IconThemeData(
                        size: 48,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: item.icon,
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    right: 4,
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.caption!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      child: item.title(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: navi.items.length,
      ),
    );
  }
}
