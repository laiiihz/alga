import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_item.dart';
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
                  child: AppTextField(
                    autofocus: true,
                    controller: _textEditingController,
                    hintText: 'Search Tools',
                    prefixIcon: const Icon(Icons.search_rounded),
                    onChanged: (text) {
                      currentTools = allItems.where((element) {
                        return element.text
                            .toLowerCase()
                            .contains(text.toLowerCase());
                      }).toList();
                      setState(() {});
                    },
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
                  title: tool.title,
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
  return await showDialog(
    context: context,
    builder: (context) => const SearchDialog(),
  );
}
