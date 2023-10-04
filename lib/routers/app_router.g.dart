// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $rootRoute,
    ];

RouteBase get $rootRoute => ShellRouteData.$route(
      factory: $RootRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/apps',
          factory: $AppsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'uuid-generator',
              factory: $UUIDGeneratorRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'hash-generator',
              factory: $HashGeneratorRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'lorem-ipsum-generator',
              factory: $LoremIpsumGeneratorRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'password-generator',
              factory: $PasswordGeneratorRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'random-file-generator',
              factory: $RandomFileGeneratorRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'sass-css-generator',
              factory: $SassCssGeneratorRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'blur-hash-tool',
              factory: $BlurHashToolRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'qrcode-tool',
              factory: $QrcodeRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'regex-test',
              factory: $RegexTestAppRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'markdown-preview',
              factory: $MarkdownPreviewRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'date-parser',
              factory: $DateParserRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'json-yaml-converter',
              factory: $JsonYamlConverterRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'number-base-converter',
              factory: $NumberBaseConverterRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'color-converter',
              factory: $ColorConverterRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'abs-length-converter',
              factory: $AbsLengthConverterRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'uri-encoder-decoder',
              factory: $UriEncoderDecoderRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'base64-encoder-decoder',
              factory: $Base64EncoderDecoderRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'gzip-compress-decompress',
              factory: $GzipCompressDecompressRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'jwt-decoder',
              factory: $JWTDecoderRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'uri-parser',
              factory: $UriParserRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'json-format',
              factory: $JsonFormatRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'dart-format',
              factory: $DartFormatRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'static-server-tool',
              factory: $StaticServerToolRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'device-info',
              factory: $DeviceInfoRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'network-info',
              factory: $NetworkInfoRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'quick-js',
              factory: $QuickJsRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/favorite',
          factory: $FavoriteRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/search',
          factory: $SearchRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/settings',
          factory: $SettingsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'licenses',
              factory: $LicensesRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $RootRouteExtension on RootRoute {
  static RootRoute _fromState(GoRouterState state) => RootRoute();
}

extension $AppsRouteExtension on AppsRoute {
  static AppsRoute _fromState(GoRouterState state) => AppsRoute();

  String get location => GoRouteData.$location(
        '/apps',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UUIDGeneratorRouteExtension on UUIDGeneratorRoute {
  static UUIDGeneratorRoute _fromState(GoRouterState state) =>
      UUIDGeneratorRoute();

  String get location => GoRouteData.$location(
        '/apps/uuid-generator',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HashGeneratorRouteExtension on HashGeneratorRoute {
  static HashGeneratorRoute _fromState(GoRouterState state) =>
      HashGeneratorRoute();

  String get location => GoRouteData.$location(
        '/apps/hash-generator',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LoremIpsumGeneratorRouteExtension on LoremIpsumGeneratorRoute {
  static LoremIpsumGeneratorRoute _fromState(GoRouterState state) =>
      LoremIpsumGeneratorRoute();

  String get location => GoRouteData.$location(
        '/apps/lorem-ipsum-generator',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PasswordGeneratorRouteExtension on PasswordGeneratorRoute {
  static PasswordGeneratorRoute _fromState(GoRouterState state) =>
      PasswordGeneratorRoute();

  String get location => GoRouteData.$location(
        '/apps/password-generator',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RandomFileGeneratorRouteExtension on RandomFileGeneratorRoute {
  static RandomFileGeneratorRoute _fromState(GoRouterState state) =>
      RandomFileGeneratorRoute();

  String get location => GoRouteData.$location(
        '/apps/random-file-generator',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SassCssGeneratorRouteExtension on SassCssGeneratorRoute {
  static SassCssGeneratorRoute _fromState(GoRouterState state) =>
      SassCssGeneratorRoute();

  String get location => GoRouteData.$location(
        '/apps/sass-css-generator',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BlurHashToolRouteExtension on BlurHashToolRoute {
  static BlurHashToolRoute _fromState(GoRouterState state) =>
      BlurHashToolRoute();

  String get location => GoRouteData.$location(
        '/apps/blur-hash-tool',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $QrcodeRouteExtension on QrcodeRoute {
  static QrcodeRoute _fromState(GoRouterState state) => QrcodeRoute();

  String get location => GoRouteData.$location(
        '/apps/qrcode-tool',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RegexTestAppRouteExtension on RegexTestAppRoute {
  static RegexTestAppRoute _fromState(GoRouterState state) =>
      RegexTestAppRoute();

  String get location => GoRouteData.$location(
        '/apps/regex-test',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MarkdownPreviewRouteExtension on MarkdownPreviewRoute {
  static MarkdownPreviewRoute _fromState(GoRouterState state) =>
      MarkdownPreviewRoute();

  String get location => GoRouteData.$location(
        '/apps/markdown-preview',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DateParserRouteExtension on DateParserRoute {
  static DateParserRoute _fromState(GoRouterState state) => DateParserRoute();

  String get location => GoRouteData.$location(
        '/apps/date-parser',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $JsonYamlConverterRouteExtension on JsonYamlConverterRoute {
  static JsonYamlConverterRoute _fromState(GoRouterState state) =>
      JsonYamlConverterRoute();

  String get location => GoRouteData.$location(
        '/apps/json-yaml-converter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NumberBaseConverterRouteExtension on NumberBaseConverterRoute {
  static NumberBaseConverterRoute _fromState(GoRouterState state) =>
      NumberBaseConverterRoute();

  String get location => GoRouteData.$location(
        '/apps/number-base-converter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ColorConverterRouteExtension on ColorConverterRoute {
  static ColorConverterRoute _fromState(GoRouterState state) =>
      ColorConverterRoute();

  String get location => GoRouteData.$location(
        '/apps/color-converter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AbsLengthConverterRouteExtension on AbsLengthConverterRoute {
  static AbsLengthConverterRoute _fromState(GoRouterState state) =>
      AbsLengthConverterRoute();

  String get location => GoRouteData.$location(
        '/apps/abs-length-converter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UriEncoderDecoderRouteExtension on UriEncoderDecoderRoute {
  static UriEncoderDecoderRoute _fromState(GoRouterState state) =>
      UriEncoderDecoderRoute();

  String get location => GoRouteData.$location(
        '/apps/uri-encoder-decoder',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $Base64EncoderDecoderRouteExtension on Base64EncoderDecoderRoute {
  static Base64EncoderDecoderRoute _fromState(GoRouterState state) =>
      Base64EncoderDecoderRoute();

  String get location => GoRouteData.$location(
        '/apps/base64-encoder-decoder',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GzipCompressDecompressRouteExtension on GzipCompressDecompressRoute {
  static GzipCompressDecompressRoute _fromState(GoRouterState state) =>
      GzipCompressDecompressRoute();

  String get location => GoRouteData.$location(
        '/apps/gzip-compress-decompress',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $JWTDecoderRouteExtension on JWTDecoderRoute {
  static JWTDecoderRoute _fromState(GoRouterState state) => JWTDecoderRoute();

  String get location => GoRouteData.$location(
        '/apps/jwt-decoder',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UriParserRouteExtension on UriParserRoute {
  static UriParserRoute _fromState(GoRouterState state) => UriParserRoute();

  String get location => GoRouteData.$location(
        '/apps/uri-parser',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $JsonFormatRouteExtension on JsonFormatRoute {
  static JsonFormatRoute _fromState(GoRouterState state) => JsonFormatRoute();

  String get location => GoRouteData.$location(
        '/apps/json-format',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DartFormatRouteExtension on DartFormatRoute {
  static DartFormatRoute _fromState(GoRouterState state) => DartFormatRoute();

  String get location => GoRouteData.$location(
        '/apps/dart-format',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StaticServerToolRouteExtension on StaticServerToolRoute {
  static StaticServerToolRoute _fromState(GoRouterState state) =>
      StaticServerToolRoute();

  String get location => GoRouteData.$location(
        '/apps/static-server-tool',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DeviceInfoRouteExtension on DeviceInfoRoute {
  static DeviceInfoRoute _fromState(GoRouterState state) => DeviceInfoRoute();

  String get location => GoRouteData.$location(
        '/apps/device-info',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NetworkInfoRouteExtension on NetworkInfoRoute {
  static NetworkInfoRoute _fromState(GoRouterState state) => NetworkInfoRoute();

  String get location => GoRouteData.$location(
        '/apps/network-info',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $QuickJsRouteExtension on QuickJsRoute {
  static QuickJsRoute _fromState(GoRouterState state) => QuickJsRoute();

  String get location => GoRouteData.$location(
        '/apps/quick-js',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FavoriteRouteExtension on FavoriteRoute {
  static FavoriteRoute _fromState(GoRouterState state) => FavoriteRoute();

  String get location => GoRouteData.$location(
        '/favorite',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SearchRouteExtension on SearchRoute {
  static SearchRoute _fromState(GoRouterState state) => SearchRoute();

  String get location => GoRouteData.$location(
        '/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LicensesRouteExtension on LicensesRoute {
  static LicensesRoute _fromState(GoRouterState state) => LicensesRoute();

  String get location => GoRouteData.$location(
        '/settings/licenses',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'8efa5f5a859fa703c363577064dea874c7796511';

/// See also [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = Provider<GoRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppRouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
