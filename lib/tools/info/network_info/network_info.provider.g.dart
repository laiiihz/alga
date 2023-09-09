// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkInfoWrapperHash() =>
    r'6dd3ab478b9e32a332466c65a032fddac5072195';

/// See also [networkInfoWrapper].
@ProviderFor(networkInfoWrapper)
final networkInfoWrapperProvider =
    AutoDisposeFutureProvider<NetworkInfoWrapper>.internal(
  networkInfoWrapper,
  name: r'networkInfoWrapperProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkInfoWrapperHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetworkInfoWrapperRef
    = AutoDisposeFutureProviderRef<NetworkInfoWrapper>;
String _$connectivityHash() => r'7bbc5a0c3eae794c60114d4f948ca1605e7e2f1d';

/// See also [connectivity].
@ProviderFor(connectivity)
final connectivityProvider =
    AutoDisposeStreamProvider<ConnectivityResult>.internal(
  connectivity,
  name: r'connectivityProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$connectivityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConnectivityRef = AutoDisposeStreamProviderRef<ConnectivityResult>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
