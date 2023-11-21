// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alga_app_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appTabControllerHash() => r'd494014d9b2281bb8749069b20abd474b5cac43a';

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

/// See also [appTabController].
@ProviderFor(appTabController)
const appTabControllerProvider = AppTabControllerFamily();

/// See also [appTabController].
class AppTabControllerFamily extends Family<Raw<TabController>> {
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
class AppTabControllerProvider extends AutoDisposeProvider<Raw<TabController>> {
  /// See also [appTabController].
  AppTabControllerProvider({
    required TickerProvider vsync,
  }) : this._internal(
          (ref) => appTabController(
            ref as AppTabControllerRef,
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
          vsync: vsync,
        );

  AppTabControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.vsync,
  }) : super.internal();

  final TickerProvider vsync;

  @override
  Override overrideWith(
    Raw<TabController> Function(AppTabControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AppTabControllerProvider._internal(
        (ref) => create(ref as AppTabControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        vsync: vsync,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Raw<TabController>> createElement() {
    return _AppTabControllerProviderElement(this);
  }

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

mixin AppTabControllerRef on AutoDisposeProviderRef<Raw<TabController>> {
  /// The parameter `vsync` of this provider.
  TickerProvider get vsync;
}

class _AppTabControllerProviderElement
    extends AutoDisposeProviderElement<Raw<TabController>>
    with AppTabControllerRef {
  _AppTabControllerProviderElement(super.provider);

  @override
  TickerProvider get vsync => (origin as AppTabControllerProvider).vsync;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
