import 'package:alga/constants/import_helper.dart';
import 'package:alga/widgets/app_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllToolsView extends ConsumerStatefulWidget {
  const AllToolsView({Key? key}) : super(key: key);

  @override
  ConsumerState<AllToolsView> createState() => _AllToolsViewState();
}

class _AllToolsViewState extends ConsumerState<AllToolsView> {
  @override
  Widget build(BuildContext context) {
    final itemRead = ref.read(currentToolProvider.notifier);
    final _navi = ref.watch(toolsProvider)!;
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
          final item = _navi.items[index];
          return Material(
            color: isDark(context) ? Colors.white12 : Colors.grey[100],
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
                        color:
                            isDark(context) ? Colors.white70 : Colors.black87,
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
        itemCount: _navi.items.length,
      ),
    );
  }
}
