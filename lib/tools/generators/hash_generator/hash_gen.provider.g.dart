// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hash_gen.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resultsHash() => r'520c380b3826d176b1a29e117341b3a322625c7a';

/// See also [results].
@ProviderFor(results)
final resultsProvider = AutoDisposeProvider<String>.internal(
  results,
  name: r'resultsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$resultsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ResultsRef = AutoDisposeProviderRef<String>;
String _$hashAlgorithmHash() => r'5ecf76988c9679c20985aee08ba1c4897a4f351a';

/// See also [HashAlgorithm].
@ProviderFor(HashAlgorithm)
final hashAlgorithmProvider =
    AutoDisposeNotifierProvider<HashAlgorithm, HashAlg>.internal(
  HashAlgorithm.new,
  name: r'hashAlgorithmProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hashAlgorithmHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HashAlgorithm = AutoDisposeNotifier<HashAlg>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
