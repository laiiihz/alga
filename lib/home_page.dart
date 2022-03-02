import 'package:devtoys/l10n/l10n.dart';
import 'package:devtoys/models/tool_items.dart';
import 'package:devtoys/views/settings_view.dart';
import 'package:devtoys/widgets/window_tool_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late NaviUtil naviUtil;
  final _suggestController = TextEditingController();

  @override
  void didChangeDependencies() {
    naviUtil = NaviUtil(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _suggestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = NavigationView(
      appBar: NavigationAppBar(
        title: Text(S.of(context).appName),
        automaticallyImplyLeading: true,
        leading: Image.asset('assets/logo/256x256.webp'),
      ),
      pane: NavigationPane(
        selected: _currentIndex,
        onChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        autoSuggestBox: AutoSuggestBox(
          controller: _suggestController,
          clearButtonEnabled: true,
          items: naviUtil.suggestItems,
          onSelected: (data) {
            int index = naviUtil.suggestGetIndex(data);
            _currentIndex = index;
            setState(() {});
          },
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        items: [...naviUtil.displayItems],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: Text(S.of(context).settings),
          ),
        ],
      ),
      content: NavigationBody.builder(
        index: _currentIndex,
        itemBuilder: (context, index) {
          if (index < naviUtil.realItems.length) {
            return naviUtil.realItems[index].page;
          }

          // return const SizedBox.shrink();
          return const SettingsView();
        },
      ),
    );

    return WindowToolWidget(child: child);
  }
}
