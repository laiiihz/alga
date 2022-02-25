import 'package:devtoys/tools/encoders_decoders/base_64_encoder_decoder/base_64_encoder_decoder.dart';
import 'package:devtoys/tools/encoders_decoders/uri_encoder_decoder/uri_encoder_decoder.dart';
import 'package:devtoys/tools/formatters/dart_formatter/dart_formatter_view.dart';
import 'package:devtoys/tools/formatters/json_formatter/json_formatter_view.dart';
import 'package:devtoys/tools/generators/hash_generator/hash_generator_view.dart';
import 'package:devtoys/tools/generators/uuid_generator/uuid_generator.dart';
import 'package:devtoys/views/settings_view.dart';
import 'package:devtoys/widgets/svg_asset_icon.dart';
import 'package:devtoys/widgets/window_tool_widget.dart';
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
    Widget child = NavigationView(
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
            icon: const Icon(FluentIcons.link),
            title: const Text('Uri'),
          ),
          PaneItem(
            icon: const SvgAssetIcon('assets/icons/Base64.svg'),
            title: const Text('Base64'),
          ),
          PaneItemHeader(header: const Text('Formatter')),
          PaneItem(
            icon: const SvgAssetIcon('assets/icons/JsonFormatter.svg'),
            title: const Text('JSON'),
          ),
          PaneItem(
            icon: const SvgAssetIcon('assets/icons/dart.svg', colorIcon: true),
            title: const Text('Dart'),
          ),
          PaneItemHeader(header: const Text('Generator')),
          PaneItem(
            icon: const SvgAssetIcon('assets/icons/Guid.svg'),
            title: const Text('UUID generator'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.fingerprint),
            title: const Text('Hash generator'),
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
          if (index == 3) return const UriEncoderDecoderView();
          if (index == 4) return const Base64EncoderDecoderView();
          if (index == 5) return const JsonFormtterView();
          if (index == 6) return const DartFormtterView();
          if (index == 7) return const UUIDGeneratorView();
          if (index == 8) return const HashGeneratorView();
          if (index == 9) return const SettingsView();
          return const SizedBox.shrink();
        },
      ),
    );

    return WindowToolWidget(child: child);
  }
}
