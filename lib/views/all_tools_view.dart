import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_items.dart';
import 'package:alga/widgets/app_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllToolsView extends ConsumerStatefulWidget {
  const AllToolsView({Key? key}) : super(key: key);

  @override
  ConsumerState<AllToolsView> createState() => _AllToolsViewState();
}

class _AllToolsViewState extends ConsumerState<AllToolsView> {
  late NaviUtil _navi;
  @override
  void didChangeDependencies() {
    _navi = NaviUtil(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final itemRead = ref.read(currentToolProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            color: isDark ? Colors.white12 : Colors.grey[100],
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                itemRead.state = item;
              },
              child: Stack(
                children: [
                  Center(
                    child: IconTheme(
                      data: IconThemeData(
                        size: 48,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      child: item.icon,
                    ),
                  ),
                  Positioned(bottom: 4, left: 4, right: 4, child: item.title),
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
