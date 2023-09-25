import 'package:alga/tools/js_tools/quick_js_tool/quick_js.provider.dart';
import 'package:alga/ui/widgets/scaffold/tool_scaffold.dart';
import 'package:alga/utils/constants/import_helper.dart';

class QuickJsView extends ConsumerWidget {
  const QuickJsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(jsContentsProvider);
    return ToolScaffold(
      title: Text(context.tr.jsTools),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.value),
            leading: item is InContent ? const Icon(Icons.arrow_right) : null,
            selected: item is InContent,
          );
        },
        reverse: true,
        itemCount: items.length,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
                child: TextField(
              maxLines: 3,
              minLines: 1,
              controller: ref.watch(jsInputControllerProvider),
            )),
            IconButton(
              onPressed: () {
                final controller = ref.read(jsInputControllerProvider);
                final content = controller.text;
                controller.clear();
                ref.read(jsContentsProvider.notifier).exec(content);
              },
              icon: const Icon(Icons.rocket_launch_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
