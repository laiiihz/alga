// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_yaml_co_converter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$processingHash() => r'adac7dd2c18cf2550f568f47b861adc4e4c898da';

/// See also [processing].
@ProviderFor(processing)
final processingProvider = AutoDisposeProvider<bool>.internal(
  processing,
  name: r'processingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$processingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProcessingRef = AutoDisposeProviderRef<bool>;
String _$jsonCVTControllerHash() => r'e7a5c0c5689db9ba86832c13b1215a069fcbac7e';

/// See also [JsonCVTController].
@ProviderFor(JsonCVTController)
final jsonCVTControllerProvider =
    AutoDisposeNotifierProvider<JsonCVTController, RichTextController>.internal(
  JsonCVTController.new,
  name: r'jsonCVTControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$jsonCVTControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JsonCVTController = AutoDisposeNotifier<RichTextController>;
String _$yamlCVTControllerHash() => r'62d8c0a6da9472e2499e3519206e3f9122ae850e';

/// See also [YamlCVTController].
@ProviderFor(YamlCVTController)
final yamlCVTControllerProvider =
    AutoDisposeNotifierProvider<YamlCVTController, RichTextController>.internal(
  YamlCVTController.new,
  name: r'yamlCVTControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$yamlCVTControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$YamlCVTController = AutoDisposeNotifier<RichTextController>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
