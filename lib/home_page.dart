import 'package:devtoys/tools/formatters/formatter_json_view.dart';
import 'package:devtoys/views/settings_view.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: const Text('DevToys'),
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
        autoSuggestBox: const AutoSuggestBox(items: []),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('All tools'),
          ),
          PaneItemHeader(header: const Text('Converters')),
          PaneItem(
            icon: const Icon(FluentIcons.transportation),
            title: const Text('JSON'),
          ),
          PaneItemHeader(header: const Text('Encoders/Decoders')),
          PaneItem(
            icon: const Icon(FluentIcons.code),
            title: const Text('HTML'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.code),
            title: const Text('URL'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.code),
            title: const Text('Base64'),
          ),
          PaneItemHeader(header: const Text('Formatter')),
          PaneItem(
            icon: const Icon(FluentIcons.accept),
            title: const Text('JSON'),
          ),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
        ],
      ),
      content: NavigationBody.builder(
        index: _currentIndex,
        itemBuilder: (context, index) {
          if (index == 5) return const FormatterJsonView();
          if (index == 6) return const SettingsView();
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
