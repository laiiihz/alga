import 'dart:io';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/home_provider.dart';
import 'package:alga/models/tool_items.dart';
import 'package:alga/views/settings_view.dart';
import 'package:alga/widgets/window_tool_widget.dart';
import 'package:window_manager/window_manager.dart';

final homeProvider = HomeProvider();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NaviUtil naviUtil;
  final _suggestController = TextEditingController();

  update() {
    setState(() {});
  }

  @override
  void initState() {
    homeProvider.addListener(update);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    naviUtil = NaviUtil(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _suggestController.dispose();
    homeProvider.removeListener(update);
    homeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget caption = const SizedBox.shrink();
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      caption = WindowCaption(
        brightness: FluentTheme.of(context).brightness,
        backgroundColor: Colors.transparent,
      );
    }
    Widget child = NavigationView(
      appBar: NavigationAppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(S.of(context).appName),
        ),
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Image.asset('assets/logo/256x256.webp'),
        ),
        actions: caption,
      ),
      pane: NavigationPane(
        selected: homeProvider.currentIndex,
        onChanged: (index) {
          homeProvider.currentIndex = index;
        },
        autoSuggestBox: AutoSuggestBox(
          placeholder: S.of(context).typeToSearch,
          trailingIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.search),
          ),
          controller: _suggestController,
          clearButtonEnabled: true,
          items: naviUtil.suggestItems,
          onSelected: (data) {
            int index = naviUtil.suggestGetIndex(data);
            homeProvider.currentIndex = index;
            setState(() {});
          },
        ),
        autoSuggestBoxReplacement: const Icon(Icons.search),
        items: [...naviUtil.displayItems],
        footerItems: [
          PaneItem(
            icon: const Icon(Icons.settings),
            title: Text(S.of(context).settings),
          ),
        ],
      ),
      content: NavigationBody.builder(
        index: homeProvider.currentIndex,
        itemBuilder: (context, index) {
          if (index < naviUtil.realItems.length) {
            return naviUtil.realItems[index].page;
          }
          return const SettingsView();
        },
      ),
    );

    return WindowToolWidget(child: child);
  }
}
