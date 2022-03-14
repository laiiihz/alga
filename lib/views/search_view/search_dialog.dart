import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/views/search_view/search_delegate.dart';
import 'package:alga/widgets/app_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchDialog extends ConsumerStatefulWidget {
  const SearchDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends ConsumerState<SearchDialog> {
  final _textEditingController = TextEditingController();
  var currentTools = <ToolItem>[];

  List<ToolItem> get allItems => ref.read(toolsProvider)!.items;

  @override
  void initState() {
    super.initState();
    currentTools = allItems;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = ref.read(currentToolProvider.notifier);
    return Dialog(
      backgroundColor: Theme.of(context).canvasColor,
      insetPadding: isSmallDevice(context)
          ? null
          : EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const BackButton(),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: _textEditingController,
                    onChanged: (text) {
                      currentTools = allItems.where((element) {
                        return element
                            .text(context)
                            .toLowerCase()
                            .contains(text.toLowerCase());
                      }).toList();
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search Tools',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
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
            ),
          ),
        ],
      ),
    );
  }
}

Future showSearchDialog(BuildContext context) async {
  if (isSmallDevice(context)) {
    return showSearch(context: context, delegate: AppSearchDelegate());
  }
  return await showDialog(
    context: context,
    builder: (context) => const SearchDialog(),
  );
}
