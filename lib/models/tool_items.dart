import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_item.dart';
import 'package:alga/tools/converters/json_yaml_converter/json_yaml_converter_view.dart';
import 'package:alga/tools/converters/number_base_converter/number_base_converter_view.dart';
import 'package:alga/tools/encoders_decoders/base_64_encoder_decoder/base_64_encoder_decoder.dart';
import 'package:alga/tools/encoders_decoders/gzip_compress_decompress/gzip_compress_decompress_view.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_decoder_view.dart';
import 'package:alga/tools/encoders_decoders/uri_encoder_decoder/uri_encoder_decoder.dart';
import 'package:alga/tools/formatters/dart_formatter/dart_formatter_view.dart';
import 'package:alga/tools/formatters/json_formatter/json_formatter_view.dart';
import 'package:alga/tools/generators/hash_generator/hash_generator_view.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_generator_view.dart';
import 'package:alga/tools/generators/sass_css_generator/sass_css_generator_view.dart';
import 'package:alga/tools/generators/uuid_generator/uuid_generator.dart';
import 'package:alga/tools/text_tools/markdown_preview/markdown_preview_view.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_view.dart';
import 'package:alga/views/all_tools_view.dart';
import 'package:alga/views/settings_view.dart';

import '../widgets/svg_asset_icon.dart';

List<ToolGroup> _genToolItems(BuildContext context) => [
      ToolGroup(
        icon: const Icon(Icons.transform),
        title: Text(S.of(context).converters),
        items: [
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/JsonYaml.svg'),
            title: Text(S.of(context).jsonYamlConverter),
            page: const JsonYamlConverterView(),
          ),
          ToolItem(
            icon: const Icon(Icons.numbers),
            title: Text(S.of(context).numberBaseConverter),
            page: const NumberBaseConverterView(),
          ),
        ],
      ),
      ToolGroup(
        icon: const Icon(Icons.compress),
        title: Text(S.of(context).encodersDecoders),
        items: [
          ToolItem(
            icon: const Icon(Icons.link),
            title: Text(S.of(context).encoderDecoderURL),
            page: const UriEncoderDecoderView(),
          ),
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/Base64.svg'),
            title: Text(S.of(context).encoderDecoderBase64),
            page: const Base64EncoderDecoderView(),
          ),
          ToolItem(
            icon: const Icon(Icons.folder_zip),
            title: Text(S.of(context).encoderDecoderGzip),
            page: const GzipCompressDecompressView(),
          ),
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/JWT.svg'),
            title: Text(S.of(context).decoderJWT),
            page: const JWTDecoderView(),
          ),
        ],
      ),
      ToolGroup(
        icon: const Icon(Icons.format_align_left),
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
        icon: const Icon(Icons.generating_tokens),
        title: Text(S.of(context).generators),
        items: [
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/Guid.svg'),
            title: Text(S.of(context).generatorUUID),
            page: const UUIDGeneratorView(),
          ),
          ToolItem(
            icon: const Icon(Icons.fingerprint),
            title: Text(S.of(context).generatorHash),
            page: const HashGeneratorView(),
          ),
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/LoremIpsum.svg'),
            title: Text(S.of(context).generatorLoremIpsum),
            page: const LoremIpsumGeneratorView(),
          ),
          ToolItem(
            icon: const Icon(Icons.add),
            title: const Text('sass css generator'),
            page: const SassCssGeneratorView(),
          ),
        ],
      ),
      ToolGroup(
        icon: const Icon(Icons.text_format),
        title: Text(S.of(context).textTool),
        items: [
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/RegexTester.svg'),
            title: Text(S.of(context).regexTester),
            page: const RegexTesterView(),
          ),
          ToolItem(
            icon: const SvgAssetIcon('assets/icons/MarkdownPreview.svg'),
            title: Text(S.of(context).markdownPreview),
            page: const MarkdownPreviewView(),
          ),
        ],
      ),
    ];

class NaviUtil {
  late List<ToolGroup> toolGroups;
  late ToolItem settingsItem;
  late ToolItem allToolsItem;

  NaviUtil(BuildContext context) {
    toolGroups = _genToolItems(context);
    settingsItem = ToolItem(
      icon: const Icon(Icons.settings),
      title: Text(S.of(context).settings),
      page: const SettingsView(),
    );
    allToolsItem = ToolItem(
      icon: const Icon(Icons.category_outlined),
      title: Text(S.of(context).allTools),
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
