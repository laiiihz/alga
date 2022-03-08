import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_items.dart';

class AllToolsView extends StatefulWidget {
  const AllToolsView({Key? key}) : super(key: key);

  @override
  State<AllToolsView> createState() => _AllToolsViewState();
}

class _AllToolsViewState extends State<AllToolsView> {
  late NaviUtil _naviUtil;

  @override
  void didChangeDependencies() {
    _naviUtil = NaviUtil(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ToolView(
      title: Text(S.of(context).allTools),
      content: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 150 / 250,
        ),
        itemBuilder: (context, index) {
          final item = _naviUtil.realItems[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              color: isDark ? Colors.grey[160] : Colors.grey[20],
              child: Column(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        color: isDark ? Colors.grey[150] : Colors.grey[30],
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        child: IconTheme(
                          data: FluentTheme.of(context)
                              .iconTheme
                              .copyWith(size: 48),
                          child: item.icon,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Center(child: item.title)),
                ],
              ),
            ),
          );
        },
        itemCount: _naviUtil.realItems.length,
      ),
    );
  }
}
