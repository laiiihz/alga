// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tools.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$booleanConfigHash() => r'98cd9a85dcb215bbc6ddc49800bd50ea8875cbc0';

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

abstract class _$BooleanConfig extends BuildlessAutoDisposeNotifier<bool> {
  late final Key key;
  late final bool defaultValue;

  bool build(
    Key key, {
    bool defaultValue = false,
  });
}

/// See also [BooleanConfig].
@ProviderFor(BooleanConfig)
const booleanConfigProvider = BooleanConfigFamily();

/// See also [BooleanConfig].
class BooleanConfigFamily extends Family<bool> {
  /// See also [BooleanConfig].
  const BooleanConfigFamily();

  /// See also [BooleanConfig].
  BooleanConfigProvider call(
    Key key, {
    bool defaultValue = false,
  }) {
    return BooleanConfigProvider(
      key,
      defaultValue: defaultValue,
    );
  }

  @override
  BooleanConfigProvider getProviderOverride(
    covariant BooleanConfigProvider provider,
  ) {
    return call(
      provider.key,
      defaultValue: provider.defaultValue,
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
  String? get name => r'booleanConfigProvider';
}

/// See also [BooleanConfig].
class BooleanConfigProvider
    extends AutoDisposeNotifierProviderImpl<BooleanConfig, bool> {
  /// See also [BooleanConfig].
  BooleanConfigProvider(
    Key key, {
    bool defaultValue = false,
  }) : this._internal(
          () => BooleanConfig()
            ..key = key
            ..defaultValue = defaultValue,
          from: booleanConfigProvider,
          name: r'booleanConfigProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$booleanConfigHash,
          dependencies: BooleanConfigFamily._dependencies,
          allTransitiveDependencies:
              BooleanConfigFamily._allTransitiveDependencies,
          key: key,
          defaultValue: defaultValue,
        );

  BooleanConfigProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
    required this.defaultValue,
  }) : super.internal();

  final Key key;
  final bool defaultValue;

  @override
  bool runNotifierBuild(
    covariant BooleanConfig notifier,
  ) {
    return notifier.build(
      key,
      defaultValue: defaultValue,
    );
  }

  @override
  Override overrideWith(BooleanConfig Function() create) {
    return ProviderOverride(
      origin: this,
      override: BooleanConfigProvider._internal(
        () => create()
          ..key = key
          ..defaultValue = defaultValue,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
        defaultValue: defaultValue,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<BooleanConfig, bool> createElement() {
    return _BooleanConfigProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BooleanConfigProvider &&
        other.key == key &&
        other.defaultValue == defaultValue;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);
    hash = _SystemHash.combine(hash, defaultValue.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BooleanConfigRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `key` of this provider.
  Key get key;

  /// The parameter `defaultValue` of this provider.
  bool get defaultValue;
}

class _BooleanConfigProviderElement
    extends AutoDisposeNotifierProviderElement<BooleanConfig, bool>
    with BooleanConfigRef {
  _BooleanConfigProviderElement(super.provider);

  @override
  Key get key => (origin as BooleanConfigProvider).key;
  @override
  bool get defaultValue => (origin as BooleanConfigProvider).defaultValue;
}

String _$stringConfigHash() => r'f0bff5e61f2c44d66b75fb93a4109bda7c7665c9';

abstract class _$StringConfig extends BuildlessAutoDisposeNotifier<String> {
  late final Key key;
  late final String defaultValue;

  String build(
    Key key, {
    String defaultValue = '',
  });
}

/// See also [StringConfig].
@ProviderFor(StringConfig)
const stringConfigProvider = StringConfigFamily();

/// See also [StringConfig].
class StringConfigFamily extends Family<String> {
  /// See also [StringConfig].
  const StringConfigFamily();

  /// See also [StringConfig].
  StringConfigProvider call(
    Key key, {
    String defaultValue = '',
  }) {
    return StringConfigProvider(
      key,
      defaultValue: defaultValue,
    );
  }

  @override
  StringConfigProvider getProviderOverride(
    covariant StringConfigProvider provider,
  ) {
    return call(
      provider.key,
      defaultValue: provider.defaultValue,
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
  String? get name => r'stringConfigProvider';
}

/// See also [StringConfig].
class StringConfigProvider
    extends AutoDisposeNotifierProviderImpl<StringConfig, String> {
  /// See also [StringConfig].
  StringConfigProvider(
    Key key, {
    String defaultValue = '',
  }) : this._internal(
          () => StringConfig()
            ..key = key
            ..defaultValue = defaultValue,
          from: stringConfigProvider,
          name: r'stringConfigProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stringConfigHash,
          dependencies: StringConfigFamily._dependencies,
          allTransitiveDependencies:
              StringConfigFamily._allTransitiveDependencies,
          key: key,
          defaultValue: defaultValue,
        );

  StringConfigProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
    required this.defaultValue,
  }) : super.internal();

  final Key key;
  final String defaultValue;

  @override
  String runNotifierBuild(
    covariant StringConfig notifier,
  ) {
    return notifier.build(
      key,
      defaultValue: defaultValue,
    );
  }

  @override
  Override overrideWith(StringConfig Function() create) {
    return ProviderOverride(
      origin: this,
      override: StringConfigProvider._internal(
        () => create()
          ..key = key
          ..defaultValue = defaultValue,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
        defaultValue: defaultValue,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<StringConfig, String> createElement() {
    return _StringConfigProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StringConfigProvider &&
        other.key == key &&
        other.defaultValue == defaultValue;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);
    hash = _SystemHash.combine(hash, defaultValue.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StringConfigRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `key` of this provider.
  Key get key;

  /// The parameter `defaultValue` of this provider.
  String get defaultValue;
}

class _StringConfigProviderElement
    extends AutoDisposeNotifierProviderElement<StringConfig, String>
    with StringConfigRef {
  _StringConfigProviderElement(super.provider);

  @override
  Key get key => (origin as StringConfigProvider).key;
  @override
  String get defaultValue => (origin as StringConfigProvider).defaultValue;
}

String _$intConfigHash() => r'd051f454fac65925e9a208694606dc480ce982cd';

abstract class _$IntConfig extends BuildlessAutoDisposeNotifier<int> {
  late final Key key;
  late final int defaultValue;

  int build(
    Key key, {
    int defaultValue = 1,
  });
}

/// See also [IntConfig].
@ProviderFor(IntConfig)
const intConfigProvider = IntConfigFamily();

/// See also [IntConfig].
class IntConfigFamily extends Family<int> {
  /// See also [IntConfig].
  const IntConfigFamily();

  /// See also [IntConfig].
  IntConfigProvider call(
    Key key, {
    int defaultValue = 1,
  }) {
    return IntConfigProvider(
      key,
      defaultValue: defaultValue,
    );
  }

  @override
  IntConfigProvider getProviderOverride(
    covariant IntConfigProvider provider,
  ) {
    return call(
      provider.key,
      defaultValue: provider.defaultValue,
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
  String? get name => r'intConfigProvider';
}

/// See also [IntConfig].
class IntConfigProvider
    extends AutoDisposeNotifierProviderImpl<IntConfig, int> {
  /// See also [IntConfig].
  IntConfigProvider(
    Key key, {
    int defaultValue = 1,
  }) : this._internal(
          () => IntConfig()
            ..key = key
            ..defaultValue = defaultValue,
          from: intConfigProvider,
          name: r'intConfigProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$intConfigHash,
          dependencies: IntConfigFamily._dependencies,
          allTransitiveDependencies: IntConfigFamily._allTransitiveDependencies,
          key: key,
          defaultValue: defaultValue,
        );

  IntConfigProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
    required this.defaultValue,
  }) : super.internal();

  final Key key;
  final int defaultValue;

  @override
  int runNotifierBuild(
    covariant IntConfig notifier,
  ) {
    return notifier.build(
      key,
      defaultValue: defaultValue,
    );
  }

  @override
  Override overrideWith(IntConfig Function() create) {
    return ProviderOverride(
      origin: this,
      override: IntConfigProvider._internal(
        () => create()
          ..key = key
          ..defaultValue = defaultValue,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
        defaultValue: defaultValue,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<IntConfig, int> createElement() {
    return _IntConfigProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IntConfigProvider &&
        other.key == key &&
        other.defaultValue == defaultValue;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);
    hash = _SystemHash.combine(hash, defaultValue.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IntConfigRef on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `key` of this provider.
  Key get key;

  /// The parameter `defaultValue` of this provider.
  int get defaultValue;
}

class _IntConfigProviderElement
    extends AutoDisposeNotifierProviderElement<IntConfig, int>
    with IntConfigRef {
  _IntConfigProviderElement(super.provider);

  @override
  Key get key => (origin as IntConfigProvider).key;
  @override
  int get defaultValue => (origin as IntConfigProvider).defaultValue;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
