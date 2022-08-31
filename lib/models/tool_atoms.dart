import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_atom.dart';
import 'package:alga/models/tool_category.dart';
import 'package:alga/tools/converters/json_yaml_converter/json_yaml_converter_view.dart';
import 'package:alga/widgets/svg_asset_icon.dart';
import 'package:alga/tools/converters/abs_length_converter/abs_length_converter_view.dart';
import 'package:alga/tools/converters/color_converter/color_converter_view.dart';
import 'package:alga/tools/converters/number_base_converter/number_base_converter_view.dart';
import 'package:alga/tools/encoders_decoders/base_64_encoder_decoder/base_64_encoder_decoder.dart';
import 'package:alga/tools/encoders_decoders/gzip_compress_decompress/gzip_compress_decompress_view.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_decoder_view.dart';
import 'package:alga/tools/encoders_decoders/uri_encoder_decoder/uri_encoder_decoder.dart';
import 'package:alga/tools/encoders_decoders/uri_parser/uri_parser_view.dart';
import 'package:alga/tools/formatters/dart_formatter/dart_formatter_view.dart';
import 'package:alga/tools/formatters/json_formatter/json_formatter_view.dart';
import 'package:alga/tools/formatters/py_dict_formatter/py_dict_formatter_view.dart';
import 'package:alga/tools/generators/hash_generator/hash_generator_view.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_generator_view.dart';
import 'package:alga/tools/generators/password_generator/password_generator_view.dart';
import 'package:alga/tools/generators/random_file_generator/random_file_generator_view.dart';
import 'package:alga/tools/generators/sm3_generator/sm3_generator_view.dart';
import 'package:alga/tools/generators/uuid_generator/uuid_generator.dart';
import 'package:alga/tools/image_tools/blur_hash_tool/blur_hash_view.dart';
import 'package:alga/tools/image_tools/qrcode_tool/qrcode_view.dart';
import 'package:alga/tools/info/device_info/device_info_view.dart';
import 'package:alga/tools/info/network_info/network_info_view.dart';
import 'package:alga/tools/js_tools/quick_js_tool/quick_js_view.dart';
import 'package:alga/tools/server_tools/static_server_tool/static_server_tool_view.dart';
import 'package:alga/tools/text_tools/date_parser/date_parser_view.dart';
import 'package:alga/tools/text_tools/markdown_preview/markdown_preview_view.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_view.dart';

import 'package:alga/tools/generators/sass_css_generator/sass_css_generator_view.dart'
    if (dart.library.js) 'package:alga/tools/generators/sass_css_generator/web/web_sass_css_generator_view.dart';

final toolAtoms = <ToolAtom>[
  // converters
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/JsonYaml.svg'),
    name: (context) => context.tr.jsonYamlConverter,
    widget: const JsonYamlConverterView(),
    categories: [ToolCategories.converters],
  ),
  ToolAtom(
    icon: const Icon(Icons.numbers),
    name: (context) => context.tr.numberBaseConverter,
    widget: const NumberBaseConverterView(),
    categories: [ToolCategories.converters],
  ),
  ToolAtom(
    icon: const Icon(Icons.color_lens),
    name: (context) => context.tr.colorConverter,
    widget: const ColorConverterView(),
    categories: [ToolCategories.converters],
  ),
  ToolAtom(
    icon: const Icon(Icons.legend_toggle),
    name: (context) => context.tr.absoluteLengthConverter,
    widget: const AbsLengthConverterView(),
    categories: [ToolCategories.converters],
  ),
  // encoders decoders
  ToolAtom(
    icon: const Icon(Icons.link),
    name: (context) => context.tr.encoderDecoderURL,
    widget: const UriEncoderDecoderView(),
    categories: [ToolCategories.encodersDecoders],
  ),
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/Base64.svg'),
    name: (context) => context.tr.encoderDecoderBase64,
    widget: const Base64EncoderDecoderView(),
    categories: [ToolCategories.encodersDecoders],
  ),
  ToolAtom(
    icon: const Icon(Icons.folder_zip),
    name: (context) => context.tr.encoderDecoderGzip,
    widget: const GzipCompressDecompressView(),
    categories: [ToolCategories.encodersDecoders],
  ),
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/JWT.svg', colorIcon: true),
    name: (context) => context.tr.decoderJWT,
    widget: const JWTDecoderView(),
    categories: [ToolCategories.encodersDecoders],
  ),
  ToolAtom(
    icon: const Icon(Icons.add_link),
    name: (context) => context.tr.uriParser,
    widget: const UriParserView(),
    categories: [ToolCategories.encodersDecoders],
  ),
  // formatters
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/json.svg', colorIcon: true),
    name: (context) => context.tr.formatterJson,
    widget: const JsonFormtterView(),
    categories: [ToolCategories.formatters],
  ),
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/dart.svg', colorIcon: true),
    name: (context) => context.tr.formatterDart,
    widget: const DartFormtterView(),
    categories: [ToolCategories.formatters],
  ),
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/python.svg', colorIcon: true),
    name: (context) => context.tr.pythonDictFormatter,
    widget: const PyDictFormatterView(),
    categories: [ToolCategories.formatters],
  ),
  // generators
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/Guid.svg'),
    name: (context) => context.tr.generatorUUID,
    widget: const UUIDGeneratorView(),
    categories: [ToolCategories.generators],
  ),
  ToolAtom(
    icon: const Icon(Icons.fingerprint),
    name: (context) => context.tr.generatorHash,
    widget: const HashGeneratorView(),
    categories: [ToolCategories.generators],
  ),
  ToolAtom(
    icon: const Icon(Icons.fingerprint),
    name: (context) => context.tr.generatorSM3Hash,
    widget: const SM3GeneratorView(),
    categories: [ToolCategories.generators],
  ),
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/LoremIpsum.svg'),
    name: (context) => context.tr.generatorLoremIpsum,
    widget: const LoremIpsumGeneratorView(),
    categories: [ToolCategories.generators],
  ),
  ToolAtom(
    icon: const Icon(Icons.password),
    name: (context) => context.tr.passGenerator,
    widget: const PasswordGeneratorView(),
    categories: [ToolCategories.generators],
  ),
  ToolAtom(
    icon: const Icon(Icons.file_copy),
    name: (context) => context.tr.randomFilegenerator,
    widget: const RandomFileGeneratorView(),
    categories: [ToolCategories.generators],
  ),
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/sass.svg', colorIcon: true),
    name: (context) => context.tr.sassCssGenerator,
    widget: const SassCssGeneratorView(),
    categories: [ToolCategories.generators],
  ),
  // text
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/RegexTester.svg'),
    name: (context) => context.tr.regexTester,
    widget: const RegexTesterView(),
    categories: [ToolCategories.textTool],
  ),
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/MarkdownPreview.svg'),
    name: (context) => context.tr.markdownPreview,
    widget: const MarkdownPreviewView(),
    categories: [ToolCategories.textTool],
  ),
  ToolAtom(
    icon: const Icon(Icons.date_range),
    name: (context) => context.tr.dateParser,
    widget: const DateParserView(),
    categories: [ToolCategories.textTool],
  ),
  // image tool
  ToolAtom(
    icon: const Icon(Icons.imagesearch_roller),
    name: (context) => context.tr.blurHashTool,
    widget: const BlurHashView(),
    categories: [ToolCategories.imageTools],
  ),
  ToolAtom(
    icon: const Icon(Icons.qr_code),
    name: (context) => context.tr.qrCodeTool,
    widget: const QrcodeView(),
    categories: [ToolCategories.imageTools],
  ),
  ToolAtom(
    icon: const Icon(Icons.file_open),
    name: (context) => context.tr.staticServerTool,
    widget: const StaticServerToolView(),
    categories: [ToolCategories.serverTools],
  ),
  // info
  ToolAtom(
    icon: const Icon(Icons.info_outline),
    name: (context) => context.tr.deviceInfo,
    widget: const DeviceInfoView(),
    categories: [ToolCategories.systemInfos],
  ),
  ToolAtom(
    icon: const Icon(Icons.network_check),
    name: (context) => context.tr.networkInfo,
    widget: const NetworkInfoView(),
    categories: [ToolCategories.systemInfos],
  ),
  ToolAtom(
    icon: const SvgAssetIcon('assets/icons/js.svg', colorIcon: true),
    name: (context) => 'Quick JS Tool',
    widget: const QuickJsView(),
    categories: [ToolCategories.jsTools],
  ),
  // ToolAtom(
  //   icon: const SvgAssetIcon('assets/icons/js.svg', colorIcon: true),
  //   name: (context) => 'Quick JS Tool',
  //   widget: const QuickJsView(),
  //   categories: [ToolCategories.jsTools],
  // ),
];

List<ToolAtom> getByCategory(ToolCategory category) {
  return toolAtoms
      .where((element) => element.categories.contains(category))
      .toList();
}

List<ToolAtom> searchByText(BuildContext context, String text) {
  if (text.isEmpty) return [];
  return toolAtoms
      .where((element) => element.name(context).contains(text))
      .toList();
}
