import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/widgets/app_scaffold.dart';

class AppSearchDelegate extends SearchDelegate {
  var currentTools = <ToolItem>[];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final allItems = ref.watch(toolsProvider)!.items;
        final currentItem = ref.read(currentToolProvider.notifier);
        final currentTools = allItems.where((element) {
          return element
              .text(context)
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
        return ListView.builder(
          itemBuilder: (context, index) {
            final tool = currentTools[index];
            return ListTile(
              title: tool.title(context),
              leading: tool.icon,
              onTap: () {
                currentItem.state = tool;
                Navigator.pop(context);
              },
            );
          },
          itemCount: currentTools.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final allItems = ref.watch(toolsProvider)!.items;
        final currentItem = ref.read(currentToolProvider.notifier);
        return ListView.builder(
          itemBuilder: (context, index) {
            final tool = allItems[index];
            return ListTile(
              title: tool.title(context),
              leading: tool.icon,
              onTap: () {
                currentItem.state = tool;
                Navigator.pop(context);
              },
            );
          },
          itemCount: allItems.length,
        );
      },
    );
  }
}
