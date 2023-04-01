// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alga_app_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appTabControllerHash() => r'291d52d5e82f24f2595cab0e4d9abca191e2b1f0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef AppTabControllerRef = AutoDisposeProviderRef<TabController>;

/// See also [appTabController].
@ProviderFor(appTabController)
const appTabControllerProvider = AppTabControllerFamily();

/// See also [appTabController].
class AppTabControllerFamily extends Family<TabController> {
  /// See also [appTabController].
  const AppTabControllerFamily();

  /// See also [appTabController].
  AppTabControllerProvider call({
    required TickerProvider vsync,
  }) {
    return AppTabControllerProvider(
      vsync: vsync,
    );
  }

  @override
  AppTabControllerProvider getProviderOverride(
    covariant AppTabControllerProvider provider,
  ) {
    return call(
      vsync: provider.vsync,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'appTabControllerProvider';
}

/// See also [appTabController].
class AppTabControllerProvider extends AutoDisposeProvider<TabController> {
  /// See also [appTabController].
  AppTabControllerProvider({
    required this.vsync,
  }) : super.internal(
          (ref) => appTabController(
            ref,
            vsync: vsync,
          ),
          from: appTabControllerProvider,
          name: r'appTabControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appTabControllerHash,
          dependencies: AppTabControllerFamily._dependencies,
          allTransitiveDependencies:
              AppTabControllerFamily._allTransitiveDependencies,
        );

  final TickerProvider vsync;

  @override
  bool operator ==(Object other) {
    return other is AppTabControllerProvider && other.vsync == vsync;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, vsync.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
