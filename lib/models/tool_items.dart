import 'package:devtoys/l10n/l10n.dart';
import 'package:devtoys/models/tool_item.dart';
import 'package:devtoys/tools/all_tools_view.dart';
import 'package:devtoys/tools/converters/json_yaml_converter/json_yaml_converter_view.dart';
import 'package:devtoys/tools/encoders_decoders/base_64_encoder_decoder/base_64_encoder_decoder.dart';
import 'package:devtoys/tools/encoders_decoders/uri_encoder_decoder/uri_encoder_decoder.dart';
import 'package:devtoys/tools/formatters/dart_formatter/dart_formatter_view.dart';
import 'package:devtoys/tools/formatters/json_formatter/json_formatter_view.dart';
import 'package:devtoys/tools/generators/hash_generator/hash_generator_view.dart';
import 'package:devtoys/tools/generators/lorem_ipsum_generator/lorem_ipsum_generator_view.dart';
import 'package:devtoys/tools/generators/uuid_generator/uuid_generator.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../widgets/svg_asset_icon.dart';

List<ToolGroup> _genToolItems(BuildContext context) => [
      ToolGroup(
        title: const Text('All Tools'),
        items: [
          ToolItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('All Tools'),
            page: const AllToolsView(),
          ),
        ],
      ),
      ToolGroup(
        title: const Text('Converters'),
        items: [
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/JsonYaml.svg'),
            title: const Text('JSON <> YAML'),
            page: const JsonYamlConverterView(),
          ),
        ],
      ),
      ToolGroup(
        title: Text(S.of(context).encodersDecoders),
        items: [
          ToolItem(
            icon: const Icon(FluentIcons.link),
            title: Text(S.of(context).encoderDecoderURL),
            page: const UriEncoderDecoderView(),
          ),
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/Base64.svg'),
            title: Text(S.of(context).encoderDecoderBase64),
            page: const Base64EncoderDecoderView(),
          ),
        ],
      ),
      ToolGroup(
        title: Text(S.of(context).formatters),
        items: [
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/JsonFormatter.svg'),
            title: Text(S.of(context).formatterJson),
            page: const JsonFormtterView(),
          ),
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/dart.svg', colorIcon: true),
            title: Text(S.of(context).formatterDart),
            page: const DartFormtterView(),
          ),
        ],
      ),
      ToolGroup(
        title: Text(S.of(context).generators),
        items: [
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/Guid.svg'),
            title: Text(S.of(context).generatorUUID),
            page: const UUIDGeneratorView(),
          ),
          ToolItem(
            icon: const Icon(FluentIcons.fingerprint),
            title: Text(S.of(context).generatorHash),
            page: const HashGeneratorView(),
          ),
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/LoremIpsum.svg'),
            title: Text(S.of(context).generatorLoremIpsum),
            page: const LoremIpsumGeneratorView(),
          ),
        ],
      ),
      ToolGroup(
        title: Text(S.of(context).textTool),
        items: [
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/MarkdownPreview.svg'),
            title: Text(S.of(context).markdownPreview),
            page: const SizedBox.shrink(),
          ),
        ],
      ),
    ];

class NaviUtil {
  late List<ToolGroup> toolGroups;
  late List<NavigationPaneItem> displayItems;
  late List<ToolItem> realItems;

  List<String> get suggestItems => realItems.map((e) => e.text).toList();

  NaviUtil(BuildContext context) {
    toolGroups = _genToolItems(context);
    var _displayItems = <NavigationPaneItem>[];
    var _realItems = <ToolItem>[];
    for (var item in toolGroups) {
      var naviItem = item.items;
      _displayItems.add(item);
      _displayItems.addAll(naviItem);
      _realItems.addAll(naviItem);
    }
    displayItems = _displayItems;
    realItems = _realItems;
  }

  int suggestGetIndex(String data) {
    int index = suggestItems.indexOf(data);
    if (index == -1) return 0;
    return index;
  }

  getIndex(ToolItem item) {
    return realItems.indexOf(item);
  }
}
