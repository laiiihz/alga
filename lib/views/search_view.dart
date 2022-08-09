import 'package:alga/alga_view/alga_view_provider.desktop.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_atom.dart';
import 'package:alga/models/tool_atoms.dart';

Future showAlgaSearch(BuildContext context) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    pageBuilder: (context, first, second) {
      return const SearchTile();
    },
  );
}

class SearchTile extends ConsumerStatefulWidget {
  const SearchTile({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends ConsumerState<SearchTile> {
  final _query = TextEditingController();
  var _toolItems = <ToolAtom>[];

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: TextField(
                    controller: _query,
                    onChanged: (text) {
                      _toolItems = searchByText(context, text);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: context.tr.search,
                      filled: false,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: _toolItems.isEmpty
                    ? const SizedBox.shrink()
                    : Material(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 256,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final item = _toolItems[index];
                              return ListTile(
                                leading: item.icon,
                                title: Text(item.name(context)),
                                onTap: () {
                                  ref.watch(currentWidget.state).state =
                                      item.widget;
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            itemCount: _toolItems.length,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
