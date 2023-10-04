import 'package:alga/tools/converters/abs_length_converter/abs_length_converter_view.dart';
import 'package:alga/tools/converters/color_converter/color_converter_view.dart';
import 'package:alga/tools/converters/json_yaml_converter/json_yaml_converter_view.dart';
import 'package:alga/tools/converters/number_base_converter/number_base_converter_view.dart';
import 'package:alga/tools/encoders_decoders/base_64_encoder_decoder/base_64_encoder_decoder.dart';
import 'package:alga/tools/encoders_decoders/gzip_compress_decompress/gzip_compress_decompress_view.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_decoder_view.dart';
import 'package:alga/tools/encoders_decoders/uri_encoder_decoder/uri_encoder_decoder.dart';
import 'package:alga/tools/encoders_decoders/uri_parser/uri_parser_view.dart';
import 'package:alga/tools/formatters/dart/dart_format.dart';
import 'package:alga/tools/formatters/json/json_format.dart';
import 'package:alga/tools/generators/hash_generator/hash_generator_view.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_generator_view.dart';
import 'package:alga/tools/generators/password_generator/password_generator_view.dart';
import 'package:alga/tools/generators/random_file_generator/random_file_generator_view.dart';
import 'package:alga/tools/generators/sass_css_generator/sass_css_generator_view.dart';
import 'package:alga/tools/image_tools/blur_hash_tool/blur_hash_tool_view.dart';
import 'package:alga/tools/image_tools/qrcode_tool/qrcode_view.dart';
import 'package:alga/tools/info/device_info/device_info.dart';
import 'package:alga/tools/info/network_info/network_info_view.dart';
import 'package:alga/tools/js_tools/quick_js_tool/quick_js_view.dart';
import 'package:alga/tools/server_tools/static_server_tool/static_server_tool_view.dart';
import 'package:alga/tools/text_tools/date_parser/date_parser_view.dart';
import 'package:alga/tools/text_tools/markdown_preview/markdown_preview_view.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_app_view.dart';
import 'package:alga/ui/alga_view/alga_view.dart';
import 'package:alga/ui/alga_view/all_apps/alga_app_view.dart';
import 'package:alga/ui/views/favorite_view.dart';
import 'package:alga/ui/views/search_view.dart';
import 'package:alga/ui/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../tools/generators/uuid_generator/uuid_generator.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _routerKey =
    GlobalKey<NavigatorState>(debugLabel: 'go_router');

BuildContext get routerContext => _routerKey.currentContext!;

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    navigatorKey: _routerKey,
    routes: $appRoutes,
    initialLocation: '/apps',
  );
}

@TypedShellRoute<RootRoute>(
  routes: [
    TypedGoRoute<AppsRoute>(path: '/apps', routes: [
      TypedGoRoute<UUIDGeneratorRoute>(path: 'uuid-generator'),
      TypedGoRoute<HashGeneratorRoute>(path: 'hash-generator'),
      TypedGoRoute<LoremIpsumGeneratorRoute>(path: 'lorem-ipsum-generator'),
      TypedGoRoute<PasswordGeneratorRoute>(path: 'password-generator'),
      TypedGoRoute<RandomFileGeneratorRoute>(path: 'random-file-generator'),
      TypedGoRoute<SassCssGeneratorRoute>(path: 'sass-css-generator'),
      TypedGoRoute<BlurHashToolRoute>(path: 'blur-hash-tool'),
      TypedGoRoute<QrcodeRoute>(path: 'qrcode-tool'),
      TypedGoRoute<RegexTestAppRoute>(path: 'regex-test'),
      TypedGoRoute<MarkdownPreviewRoute>(path: 'markdown-preview'),
      TypedGoRoute<DateParserRoute>(path: 'date-parser'),
      TypedGoRoute<JsonYamlConverterRoute>(path: 'json-yaml-converter'),
      TypedGoRoute<NumberBaseConverterRoute>(path: 'number-base-converter'),
      TypedGoRoute<ColorConverterRoute>(path: 'color-converter'),
      TypedGoRoute<AbsLengthConverterRoute>(path: 'abs-length-converter'),
      TypedGoRoute<UriEncoderDecoderRoute>(path: 'uri-encoder-decoder'),
      TypedGoRoute<Base64EncoderDecoderRoute>(path: 'base64-encoder-decoder'),
      TypedGoRoute<GzipCompressDecompressRoute>(
          path: 'gzip-compress-decompress'),
      TypedGoRoute<JWTDecoderRoute>(path: 'jwt-decoder'),
      TypedGoRoute<UriParserRoute>(path: 'uri-parser'),
      TypedGoRoute<JsonFormatRoute>(path: 'json-format'),
      TypedGoRoute<DartFormatRoute>(path: 'dart-format'),
      TypedGoRoute<StaticServerToolRoute>(path: 'static-server-tool'),
      TypedGoRoute<DeviceInfoRoute>(path: 'device-info'),
      TypedGoRoute<NetworkInfoRoute>(path: 'network-info'),
      TypedGoRoute<QuickJsRoute>(path: 'quick-js'),
    ]),
    TypedGoRoute<FavoriteRoute>(path: '/favorite'),
    TypedGoRoute<SearchRoute>(path: '/search'),
    TypedGoRoute<SettingsRoute>(path: '/settings', routes: [
      TypedGoRoute<LicensesRoute>(path: 'licenses'),
    ]),
  ],
)
class RootRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AlgaShellRouteView(child: navigator);
  }
}
