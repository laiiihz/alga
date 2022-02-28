import 'package:devtoys/models/tool_item.dart';
import 'package:devtoys/tools/encoders_decoders/base_64_encoder_decoder/base_64_encoder_decoder.dart';
import 'package:devtoys/tools/encoders_decoders/uri_encoder_decoder/uri_encoder_decoder.dart';
import 'package:devtoys/tools/formatters/dart_formatter/dart_formatter_view.dart';
import 'package:devtoys/tools/formatters/json_formatter/json_formatter_view.dart';
import 'package:devtoys/tools/generators/hash_generator/hash_generator_view.dart';
import 'package:devtoys/tools/generators/uuid_generator/uuid_generator.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../widgets/svg_asset_icon.dart';

List<ToolGroup> toolItems = [
  ToolGroup(
    title: const Text('Encoders/Decoders'),
    items: [
      ToolItem(
        icon: const Icon(FluentIcons.link),
        title: const Text('URL'),
        page: const UriEncoderDecoderView(),
      ),
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/Base64.svg'),
        title: const Text('Base64'),
        page: const Base64EncoderDecoderView(),
      ),
    ],
  ),
  ToolGroup(
    title: const Text('Formatter'),
    items: [
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/JsonFormatter.svg'),
        title: const Text('JSON'),
        page: const JsonFormtterView(),
      ),
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/dart.svg', colorIcon: true),
        title: const Text('Dart'),
        page: const DartFormtterView(),
      ),
    ],
  ),
  ToolGroup(
    title: const Text('Generator'),
    items: [
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/Guid.svg'),
        title: const Text('UUID generator'),
        page: const UUIDGeneratorView(),
      ),
      ToolItem(
        icon: const Icon(FluentIcons.fingerprint),
        title: const Text('Hash generator'),
        page: const HashGeneratorView(),
      ),
    ],
  ),
];

class NaviUtil {
  late List<NavigationPaneItem> displayItems;
  late List<ToolItem> realItems;

  NaviUtil() {
    var _displayItems = <NavigationPaneItem>[];
    var _realItems = <ToolItem>[];
    for (var item in toolItems) {
      var naviItem = item.items;
      _displayItems.add(item);
      _displayItems.addAll(naviItem);
      _realItems.addAll(naviItem);
    }
    displayItems = _displayItems;
    realItems = _realItems;
  }
}
