// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alga/models/app_category.dart';
import 'package:alga/routers/app_router.dart';
import 'package:alga/tools/tools.dart';
import 'package:alga/ui/widgets/svg_asset_icon.dart';
import 'package:alga/utils/constants/import_helper.dart';

typedef ContextBuilder<T> = T Function(BuildContext context);

enum AppPlatform {
  android,
  ios,
  windows,
  linux,
  web,
  ;

  static List<AppPlatform> except(
      {AppPlatform? platform, List<AppPlatform>? platforms}) {
    List<AppPlatform> result = AppPlatform.values;
    if (platform != null) {
      result = result.where((element) => element != platform).toList();
    }
    if (platforms != null && platforms.isNotEmpty) {
      result = result.where((element) => !platforms.contains(element)).toList();
    }
    return result;
  }
}

class AppAtom {
  AppAtom({
    required this.title,
    required this.icon,
    required this.path,
    required this.categories,
    this.platforms = AppPlatform.values,
  });
  final ContextBuilder<String> title;
  final Widget icon;
  final String path;
  final List<AppCategory> categories;

  /// support platforms
  final List<AppPlatform> platforms;
  static final items = <AppAtom>{
    ...generators,
    ...photoApps,
    ...converters,
    ...textApps,
    ...designApps,
    ...encoderDecoderApps,
    ...formatterApps,
    ...frontEndApps,
    ...infomationApps,
    ...serverApps,
  };

  static final generators = <AppAtom>[
    uuidGenerator,
    hashGenerator,
    loremIpsumGenerator,
    passwordGenerator,
    randomFileGenerator,
    sass2CssGenerator,
    qrcode,
  ];
  static final photoApps = <AppAtom>[blurhash, qrcode];
  static final textApps = <AppAtom>[regex, markdown, dateParser];
  static final converters = <AppAtom>[
    sass2CssGenerator,
    jsonYamlConverter,
    numberBaseConverter,
    colorConverter,
  ];
  static final designApps = <AppAtom>[colorConverter];
  static final encoderDecoderApps = <AppAtom>[
    urlEncoderDecoder,
    base64,
    gzip,
    jwtDecoder,
    uriParser,
  ];
  static final formatterApps = <AppAtom>[
    jsonFormatter,
    dartFormatter,
  ];

  static final frontEndApps = <AppAtom>[
    quickJs,
    sass2CssGenerator,
  ];

  static final infomationApps = <AppAtom>[
    deviceInfo,
    networkInfo,
  ];

  static final serverApps = <AppAtom>[staticServer];

  // ----------- generators -----------
  static final uuidGenerator = AppAtom(
    title: (context) => context.tr.generatorUUID,
    icon: const SvgAssetIcon('assets/icons/Guid.svg'),
    path: UUIDGenRoute().location,
    categories: [AppCategory.generator],
  );

  static final hashGenerator = AppAtom(
    title: (context) => context.tr.generatorHash,
    icon: const Icon(Icons.fingerprint),
    path: HashGenRoute().location,
    categories: [AppCategory.generator],
  );

  static final loremIpsumGenerator = AppAtom(
    title: (context) => context.tr.generatorLoremIpsum,
    icon: const SvgAssetIcon('assets/icons/LoremIpsum.svg'),
    path: LoremIpsumGenRoute().location,
    categories: [AppCategory.generator],
  );

  static final passwordGenerator = AppAtom(
    title: (context) => context.tr.passGenerator,
    icon: const Icon(Icons.password),
    path: PasswordGenRoute().location,
    categories: [AppCategory.generator],
  );

  static final randomFileGenerator = AppAtom(
    icon: const Icon(Icons.file_copy),
    title: (context) => context.tr.randomFilegenerator,
    path: RandomFileGeneratorRoute().location,
    categories: [AppCategory.generator],
    platforms: AppPlatform.except(platforms: [AppPlatform.android]),
  );

  static final sass2CssGenerator = AppAtom(
    icon: const SvgAssetIcon('assets/icons/sass.svg', colorIcon: true),
    title: (context) => context.tr.sassCssGenerator,
    path: Sass2cssRoute().location,
    categories: [
      AppCategory.generator,
      AppCategory.converter,
      AppCategory.frontEnd,
    ],
    platforms: AppPlatform.except(platform: AppPlatform.web),
  );

  static final blurhash = AppAtom(
    title: (context) => context.tr.blurHashTool,
    icon: const Icon(Icons.imagesearch_roller),
    path: BlurHashRoute().location,
    categories: [AppCategory.photo],
  );

  static final qrcode = AppAtom(
    icon: const Icon(Icons.qr_code),
    title: (context) => context.tr.qrCodeTool,
    path: QrCodeRoute().location,
    categories: [AppCategory.photo, AppCategory.generator],
  );

  static final regex = AppAtom(
    icon: const SvgAssetIcon('assets/icons/RegexTester.svg'),
    title: (context) => context.tr.regexTester,
    path: RegexTesterRoute().location,
    categories: [AppCategory.text],
  );

  static final markdown = AppAtom(
    icon: const SvgAssetIcon('assets/icons/MarkdownPreview.svg'),
    title: (context) => context.tr.markdownPreview,
    path: MarkdownPreviewRoute().location,
    categories: [AppCategory.text],
  );

  static final dateParser = AppAtom(
    icon: const Icon(Icons.date_range),
    title: (context) => context.tr.dateParser,
    path: DateParserRoute().location,
    categories: [AppCategory.text],
  );

  static final jsonYamlConverter = AppAtom(
    icon: const SvgAssetIcon('assets/icons/JsonYaml.svg'),
    title: (context) => context.tr.jsonYamlConverter,
    path: JsonYamlConverterRoute().location,
    categories: [AppCategory.converter],
  );

  static final numberBaseConverter = AppAtom(
    icon: const Icon(Icons.numbers),
    title: (context) => context.tr.numberBaseConverter,
    path: NumberBaseConverterRoute().location,
    categories: [AppCategory.converter],
  );

  static final colorConverter = AppAtom(
    icon: const Icon(Icons.color_lens),
    title: (context) => context.tr.colorConverter,
    path: ColorConverterRoute().location,
    categories: [AppCategory.converter, AppCategory.design],
  );

  static final absLengthConverter = AppAtom(
    icon: const Icon(Icons.legend_toggle),
    title: (context) => context.tr.absoluteLengthConverter,
    path: AbsLengthConverterRoute().location,
    categories: [AppCategory.converter],
  );

  static final urlEncoderDecoder = AppAtom(
    icon: const Icon(Icons.link),
    title: (context) => context.tr.encoderDecoderURL,
    path: UriEncoderDecoderRoute().location,
    categories: [AppCategory.encodersDecoders],
  );

  static final base64 = AppAtom(
    icon: const SvgAssetIcon('assets/icons/Base64.svg'),
    title: (context) => context.tr.encoderDecoderBase64,
    path: Base64EncoderDecoderRoute().location,
    categories: [AppCategory.encodersDecoders],
  );

  static final gzip = AppAtom(
    icon: const Icon(Icons.folder_zip),
    title: (context) => context.tr.encoderDecoderGzip,
    path: GzipCompressDecompressRoute().location,
    categories: [AppCategory.encodersDecoders],
  );

  static final jwtDecoder = AppAtom(
    icon: const SvgAssetIcon('assets/icons/JWT.svg', colorIcon: true),
    title: (context) => context.tr.decoderJWT,
    path: JWTDecoderRoute().location,
    categories: [AppCategory.encodersDecoders],
  );

  static final uriParser = AppAtom(
    icon: const Icon(Icons.add_link),
    title: (context) => context.tr.uriParser,
    path: UriParserRoute().location,
    categories: [AppCategory.encodersDecoders],
  );

  static final jsonFormatter = AppAtom(
    icon: const SvgAssetIcon('assets/icons/json.svg', colorIcon: true),
    title: (context) => context.tr.formatterJson,
    path: JsonFormatterRoute().location,
    categories: [AppCategory.formatter],
  );
  static final dartFormatter = AppAtom(
    icon: const SvgAssetIcon('assets/icons/dart.svg', colorIcon: true),
    title: (context) => context.tr.formatterDart,
    path: DartFormatterRoute().location,
    categories: [AppCategory.formatter],
  );

  static final staticServer = AppAtom(
    icon: const Icon(Icons.file_open),
    title: (context) => context.tr.staticServerTool,
    path: StaticServerToolRoute().location,
    categories: [AppCategory.server],
  );
  // info
  static final deviceInfo = AppAtom(
    icon: const Icon(Icons.info_outline),
    title: (context) => context.tr.deviceInfo,
    path: DeviceInfoRoute().location,
    categories: [AppCategory.infomation],
  );
  static final networkInfo = AppAtom(
    icon: const Icon(Icons.network_check),
    title: (context) => context.tr.networkInfo,
    path: NetworkInfoRoute().location,
    categories: [AppCategory.infomation],
  );
  static final quickJs = AppAtom(
    icon: const SvgAssetIcon('assets/icons/js.svg', colorIcon: true),
    title: (context) => 'Quick JS Tool',
    path: QuickJsRoute().location,
    categories: [AppCategory.frontEnd],
  );
}
