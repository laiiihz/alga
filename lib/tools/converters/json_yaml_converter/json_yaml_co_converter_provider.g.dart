// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_yaml_co_converter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String _$JsonCVTControllerHash() => r'ee129dfd188a262a2cc5821d5a0197f68eda5c7f';

/// See also [JsonCVTController].
final jsonCVTControllerProvider =
    AutoDisposeNotifierProvider<JsonCVTController, RichTextController>(
  JsonCVTController.new,
  name: r'jsonCVTControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$JsonCVTControllerHash,
);
typedef JsonCVTControllerRef
    = AutoDisposeNotifierProviderRef<RichTextController>;

abstract class _$JsonCVTController
    extends AutoDisposeNotifier<RichTextController> {
  @override
  RichTextController build();
}

String _$yamlCVTControllerHash() => r'4a27122a7d50c46500d037342afe6deb8bba558a';

/// See also [yamlCVTController].
final yamlCVTControllerProvider = AutoDisposeProvider<RichTextController>(
  yamlCVTController,
  name: r'yamlCVTControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$yamlCVTControllerHash,
);
typedef YamlCVTControllerRef = AutoDisposeProviderRef<RichTextController>;
