import 'package:alga/tools/tools.dart';
import 'package:alga/ui/alga_view/alga_view.dart';
import 'package:alga/ui/alga_view/all_apps/alga_app_view.dart';
import 'package:alga/ui/views/favorite_view.dart';
import 'package:alga/ui/views/search_view.dart';
import 'package:alga/ui/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
      TypedGoRoute<UUIDGenRoute>(path: 'uuid-generator'),
      TypedGoRoute<HashGenRoute>(path: 'hash-generator'),
      TypedGoRoute<LoremIpsumGenRoute>(path: 'lorem-ipsum-generator'),
      TypedGoRoute<PasswordGenRoute>(path: 'password-generator'),
      TypedGoRoute<RandomFileGeneratorRoute>(path: 'random-file-generator'),
      TypedGoRoute<Sass2cssRoute>(path: 'sass-css-generator'),
      TypedGoRoute<BlurHashRoute>(path: 'blur-hash-tool'),
      TypedGoRoute<QrCodeRoute>(path: 'qrcode-tool'),
      TypedGoRoute<RegexTesterRoute>(path: 'regex-test'),
      TypedGoRoute<MarkdownPreviewRoute>(path: 'markdown-preview'),
      TypedGoRoute<DateParserRoute>(path: 'date-parser'),
      TypedGoRoute<CommonConverterRoute>(path: 'common-converter'),
      TypedGoRoute<NumberBaseConverterRoute>(path: 'number-base-converter'),
      TypedGoRoute<ColorConverterRoute>(path: 'color-converter'),
      TypedGoRoute<UriCodecRoute>(path: 'uri-encoder-decoder'),
      TypedGoRoute<Base64CodecRoute>(path: 'base64-encoder-decoder'),
      TypedGoRoute<GZipCompressRoute>(path: 'gzip-compress-decompress'),
      TypedGoRoute<JwtDecoderRoute>(path: 'jwt-decoder'),
      TypedGoRoute<UriParserRoute>(path: 'uri-parser'),
      TypedGoRoute<JsonFormatterRoute>(path: 'json-format'),
      TypedGoRoute<DartFormatterRoute>(path: 'dart-format'),
      TypedGoRoute<StaticServerRoute>(path: 'static-server-tool'),
      TypedGoRoute<DeviceInfoRoute>(path: 'device-info'),
      TypedGoRoute<NetworkInfoRoute>(path: 'network-info'),
      TypedGoRoute<QuickJsRoute>(path: 'quick-js'),
    ]),
    TypedGoRoute<FavoriteRoute>(path: '/favorite'),
    TypedGoRoute<SearchRoute>(path: '/search'),
    TypedGoRoute<SettingsRoute>(path: '/settings'),
  ],
)
class RootRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AlgaShellRouteView(child: navigator);
  }
}
