import 'dart:io';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/tools/converters/json_yaml_converter/json_yaml_converter_view.dart';
import 'package:alga/tools/converters/number_base_converter/number_base_converter_view.dart';
import 'package:alga/tools/encoders_decoders/base_64_encoder_decoder/base_64_encoder_decoder.dart';
import 'package:alga/tools/encoders_decoders/gzip_compress_decompress/gzip_compress_decompress_view.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_decoder_view.dart';
import 'package:alga/tools/encoders_decoders/uri_encoder_decoder/uri_encoder_decoder.dart';
import 'package:alga/tools/encoders_decoders/uri_parser/uri_parser_view.dart';
import 'package:alga/tools/formatters/dart_formatter/dart_formatter_view.dart';
import 'package:alga/tools/formatters/json_formatter/json_formatter_view.dart';
import 'package:alga/tools/generators/hash_generator/hash_generator_view.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_generator_view.dart';
import 'package:alga/tools/generators/sass_css_generator/sass_css_generator_view.dart';
import 'package:alga/tools/generators/uuid_generator/uuid_generator.dart';
import 'package:alga/tools/image_tools/blur_hash_tool/blur_hash_view.dart';
import 'package:alga/tools/image_tools/qrcode_tool/qrcode_view.dart';
import 'package:alga/tools/server_tools/static_server_tool/static_server_tool_view.dart';
import 'package:alga/tools/text_tools/markdown_preview/markdown_preview_view.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_view.dart';
import 'package:alga/views/all_tools_view.dart';
import 'package:alga/views/settings_view.dart';

import '../widgets/svg_asset_icon.dart';

List<ToolGroup> _toolItems = [
  ToolGroup(
    icon: const Icon(Icons.transform),
    title: (context) => Text(S.of(context).converters),
    items: [
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/JsonYaml.svg'),
        title: (context) => Text(S.of(context).jsonYamlConverter),
        page: const JsonYamlConverterView(),
      ),
      ToolItem(
        icon: const Icon(Icons.numbers),
        title: (context) => Text(S.of(context).numberBaseConverter),
        page: const NumberBaseConverterView(),
      ),
    ],
  ),
  ToolGroup(
    icon: const Icon(Icons.compress),
    title: (context) => Text(S.of(context).encodersDecoders),
    items: [
      ToolItem(
        icon: const Icon(Icons.link),
        title: (context) => Text(S.of(context).encoderDecoderURL),
        page: const UriEncoderDecoderView(),
      ),
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/Base64.svg'),
        title: (context) => Text(S.of(context).encoderDecoderBase64),
        page: const Base64EncoderDecoderView(),
      ),
      ToolItem(
        icon: const Icon(Icons.folder_zip),
        title: (context) => Text(S.of(context).encoderDecoderGzip),
        page: const GzipCompressDecompressView(),
      ),
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/JWT.svg', colorIcon: true),
        title: (context) => Text(S.of(context).decoderJWT),
        page: const JWTDecoderView(),
      ),
      ToolItem(
        icon: const Icon(Icons.add_link),
        title: (context) => Text(S.of(context).uriParser),
        page: const UriParserView(),
      ),
    ],
  ),
  ToolGroup(
    icon: const Icon(Icons.format_align_left),
    title: (context) => Text(S.of(context).formatters),
    items: [
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/JsonFormatter.svg'),
        title: (context) => Text(S.of(context).formatterJson),
        page: const JsonFormtterView(),
      ),
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/dart.svg', colorIcon: true),
        title: (context) => Text(S.of(context).formatterDart),
        page: const DartFormtterView(),
      ),
    ],
  ),
  ToolGroup(
    icon: const Icon(Icons.generating_tokens),
    title: (context) => Text(S.of(context).generators),
    items: [
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/Guid.svg'),
        title: (context) => Text(S.of(context).generatorUUID),
        page: const UUIDGeneratorView(),
      ),
      ToolItem(
        icon: const Icon(Icons.fingerprint),
        title: (context) => Text(S.of(context).generatorHash),
        page: const HashGeneratorView(),
      ),
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/LoremIpsum.svg'),
        title: (context) => Text(S.of(context).generatorLoremIpsum),
        page: const LoremIpsumGeneratorView(),
      ),
      ToolItem(
        icon: const Icon(Icons.add),
        title: (context) => Text(S.of(context).sassCssGenerator),
        page: const SassCssGeneratorView(),
      ),
    ],
  ),
  ToolGroup(
    icon: const Icon(Icons.text_format),
    title: (context) => Text(S.of(context).textTool),
    items: [
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/RegexTester.svg'),
        title: (context) => Text(S.of(context).regexTester),
        page: const RegexTesterView(),
      ),
      ToolItem(
        icon: const SvgAssetIcon('assets/icons/MarkdownPreview.svg'),
        title: (context) => Text(S.of(context).markdownPreview),
        page: const MarkdownPreviewView(),
      ),
    ],
  ),
  ToolGroup(
    icon: const Icon(Icons.image),
    title: (context) => const Text('Image Tool'),
    items: [
      ToolItem(
        icon: const Icon(Icons.imagesearch_roller),
        title: (context) => const Text('Blur Hash Tool'),
        page: const BlurHashView(),
      ),
      ToolItem(
        icon: const Icon(Icons.qr_code),
        title: (context) => const Text('Qr Code Tool'),
        page: const QrcodeView(),
      ),
    ],
  ),
  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows)
    ToolGroup(
      title: (context) => Text(S.of(context).serverTools),
      items: [
        ToolItem(
          icon: const Icon(Icons.file_open),
          title: (context) => Text(S.of(context).staticServerTool),
          page: const StaticServerToolView(),
        ),
      ],
      icon: const Icon(Icons.open_in_browser),
    ),
];

class NaviUtil {
  late List<ToolGroup> toolGroups = _toolItems;
  late ToolItem settingsItem;
  late ToolItem allToolsItem;

  NaviUtil() {
    settingsItem = ToolItem(
      icon: const Icon(Icons.settings),
      title: (context) => Text(S.of(context).settings),
      page: const SettingsView(),
    );
    allToolsItem = ToolItem(
      icon: const Icon(Icons.category_outlined),
      title: (context) => Text(S.of(context).allTools),
      page: const AllToolsView(),
    );
  }
  List<ToolItem> get items {
    var items = <ToolItem>[];
    for (var item in toolGroups) {
      items.addAll(item.items);
    }
    return items;
  }
}
