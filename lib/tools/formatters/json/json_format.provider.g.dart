// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_format.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jsonIndentHash() => r'0ecbdc98b481d3af97259fb1136964f4d3032128';

/// See also [JsonIndent].
@ProviderFor(JsonIndent)
final jsonIndentProvider =
    NotifierProvider<JsonIndent, JsonIndentType>.internal(
  JsonIndent.new,
  name: r'jsonIndentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jsonIndentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JsonIndent = Notifier<JsonIndentType>;
String _$jsonContentHash() => r'e16c178e258524cde0997beebf855756c7229a59';

/// See also [JsonContent].
@ProviderFor(JsonContent)
final jsonContentProvider =
    AutoDisposeNotifierProvider<JsonContent, Raw<RichTextController>>.internal(
  JsonContent.new,
  name: r'jsonContentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jsonContentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JsonContent = AutoDisposeNotifier<Raw<RichTextController>>;
String _$jsonFormatLoadingHash() => r'83f5ca6966c768be50b9652b96180f5fddee039a';

/// See also [JsonFormatLoading].
@ProviderFor(JsonFormatLoading)
final jsonFormatLoadingProvider =
    AutoDisposeNotifierProvider<JsonFormatLoading, bool>.internal(
  JsonFormatLoading.new,
  name: r'jsonFormatLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$jsonFormatLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JsonFormatLoading = AutoDisposeNotifier<bool>;
String _$errorMessageHash() => r'96d341807f56317a206de2a92405ce08d17645ed';

/// See also [ErrorMessage].
@ProviderFor(ErrorMessage)
final errorMessageProvider =
    AutoDisposeNotifierProvider<ErrorMessage, String?>.internal(
  ErrorMessage.new,
  name: r'errorMessageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$errorMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ErrorMessage = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
