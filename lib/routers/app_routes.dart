import 'package:alga/ui/alga_view/all_apps/alga_app_view.dart';
import 'package:alga/ui/alga_view/alga_view.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/models/app_atom.dart';
import 'package:alga/tools/converters/abs_length_converter/abs_length_converter_view.dart';
import 'package:alga/tools/converters/color_converter/color_converter_view.dart';
import 'package:alga/tools/converters/json_yaml_converter/json_yaml_converter_view.dart';
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
import 'package:alga/tools/generators/sass_css_generator/sass_css_generator_view.dart';
import 'package:alga/tools/generators/uuid_generator/uuid_generator.dart';
import 'package:alga/tools/image_tools/blur_hash_tool/blur_hash_tool_view.dart';
import 'package:alga/tools/image_tools/qrcode_tool/qrcode_view.dart';
import 'package:alga/tools/info/device_info/device_info_view.dart';
import 'package:alga/tools/info/network_info/network_info_view.dart';
import 'package:alga/tools/js_tools/quick_js_tool/quick_js_view.dart';
import 'package:alga/tools/server_tools/static_server_tool/static_server_tool_view.dart';
import 'package:alga/tools/text_tools/date_parser/date_parser_view.dart';
import 'package:alga/tools/text_tools/markdown_preview/markdown_preview_view.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_app_view.dart';
import 'package:alga/ui/views/favorite_view.dart';
import 'package:alga/ui/views/search_view.dart';
import 'package:alga/ui/views/settings_view.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _routerKey =
    GlobalKey<NavigatorState>(debugLabel: 'go_router');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

BuildContext get routerContext => _routerKey.currentContext!;
BuildContext get shellContext => _shellNavigatorKey.currentContext!;

final appRouter = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: '/apps',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AlgaShellRouteView(child: child);
      },
      routes: [
        GoRoute(
          path: '/favorite',
          builder: (context, state) => const FavoriteView(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchView(),
        ),
        GoRoute(
          path: '/apps',
          builder: (context, state) => const AlgaAppView(),
          routes: [
            GoRoute(
              path: AppAtom.uuidGenerator.path,
              builder: (context, state) => const UUIDGeneratorView(),
            ),
            GoRoute(
              path: AppAtom.hashGenerator.path,
              builder: (context, state) => const HashGeneratorView(),
            ),
            GoRoute(
              path: AppAtom.loremIpsumGenerator.path,
              builder: (context, state) => const LoremIpsumGeneratorView(),
            ),
            GoRoute(
              path: AppAtom.passwordGenerator.path,
              builder: (context, state) => const PasswordGeneratorView(),
            ),
            GoRoute(
              path: AppAtom.randomFileGenerator.path,
              builder: (context, state) => const RandomFileGeneratorView(),
            ),
            GoRoute(
              path: AppAtom.sass2CssGenerator.path,
              builder: (context, state) => const SassCssGeneratorView(),
            ),
            GoRoute(
              path: AppAtom.blurhash.path,
              builder: (context, state) => const BlurHashToolView(),
            ),
            GoRoute(
              path: AppAtom.qrcode.path,
              builder: (context, state) => const QrcodeView(),
            ),
            GoRoute(
              path: AppAtom.regex.path,
              builder: (context, state) => const RegexTestAppView(),
            ),
            GoRoute(
              path: AppAtom.markdown.path,
              builder: (context, state) => const MarkdownPreviewView(),
            ),
            GoRoute(
              path: AppAtom.dateParser.path,
              builder: (context, state) => const DateParserView(),
            ),
            GoRoute(
              path: AppAtom.jsonYamlConverter.path,
              builder: (context, state) => const JsonYamlConverterView(),
            ),
            GoRoute(
              path: AppAtom.numberBaseConverter.path,
              builder: (context, state) => const NumberBaseConverterView(),
            ),
            GoRoute(
              path: AppAtom.colorConverter.path,
              builder: (context, state) => const ColorConverterView(),
            ),
            GoRoute(
              path: AppAtom.absLengthConverter.path,
              builder: (context, state) => const AbsLengthConverterView(),
            ),
            GoRoute(
              path: AppAtom.urlEncoderDecoder.path,
              builder: (context, state) => const UriEncoderDecoderView(),
            ),
            GoRoute(
              path: AppAtom.base64.path,
              builder: (context, state) => const Base64EncoderDecoderView(),
            ),
            GoRoute(
              path: AppAtom.gzip.path,
              builder: (context, state) => const GzipCompressDecompressView(),
            ),
            GoRoute(
              path: AppAtom.jwtDecoder.path,
              builder: (context, state) => const JWTDecoderView(),
            ),
            GoRoute(
              path: AppAtom.uriParser.path,
              builder: (context, state) => const UriParserView(),
            ),
            GoRoute(
              path: AppAtom.jsonFormatter.path,
              builder: (context, state) => const JsonFormatterView(),
            ),
            GoRoute(
              path: AppAtom.dartFormatter.path,
              builder: (context, state) => const DartFormtterView(),
            ),
            GoRoute(
              path: AppAtom.pyDictFormatter.path,
              builder: (context, state) => const PyDictFormatterView(),
            ),
            GoRoute(
              path: AppAtom.staticServer.path,
              builder: (context, state) => const StaticServerToolView(),
            ),
            GoRoute(
              path: AppAtom.deviceInfo.path,
              builder: (context, state) => const DeviceInfoView(),
            ),
            GoRoute(
              path: AppAtom.networkInfo.path,
              builder: (context, state) => const NetworkInfoView(),
            ),
            GoRoute(
              path: AppAtom.quickJs.path,
              builder: (context, state) => const QuickJsView(),
            ),
          ],
        ),
        GoRoute(
          path: '/pipe',
          builder: (context, state) => const Scaffold(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsView(),
          routes: [
            GoRoute(
              path: 'licenses',
              builder: (context, state) => const LicensePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
