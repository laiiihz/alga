// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_js.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jsEngineHash() => r'0e20faa1e9d0eec05a1c7065099add6865061b34';

/// See also [jsEngine].
@ProviderFor(jsEngine)
final jsEngineProvider = Provider<JavascriptRuntime>.internal(
  jsEngine,
  name: r'jsEngineProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jsEngineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JsEngineRef = ProviderRef<JavascriptRuntime>;
String _$jsInputControllerHash() => r'5bd55c55e939691355ae48b14a3749a43432bbe0';

/// See also [jsInputController].
@ProviderFor(jsInputController)
final jsInputControllerProvider =
    AutoDisposeProvider<Raw<TextEditingController>>.internal(
  jsInputController,
  name: r'jsInputControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$jsInputControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JsInputControllerRef
    = AutoDisposeProviderRef<Raw<TextEditingController>>;
String _$jsContentsHash() => r'8cb6199c822ff862f09106d570f7577e0bbeb95e';

/// See also [JsContents].
@ProviderFor(JsContents)
final jsContentsProvider =
    AutoDisposeNotifierProvider<JsContents, List<JsContent>>.internal(
  JsContents.new,
  name: r'jsContentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jsContentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JsContents = AutoDisposeNotifier<List<JsContent>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
