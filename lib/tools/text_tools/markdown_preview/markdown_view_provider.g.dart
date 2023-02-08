// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markdown_view_provider.dart';

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

String _$markdownControllerHash() =>
    r'fc0e288c48d07bcc2c98b6e579a6ad985e529c2a';

/// See also [markdownController].
final markdownControllerProvider = AutoDisposeProvider<RichTextController>(
  markdownController,
  name: r'markdownControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$markdownControllerHash,
);
typedef MarkdownControllerRef = AutoDisposeProviderRef<RichTextController>;
String _$markdownValueHash() => r'60d40d8ae31096a904836f1cd29566359831ff79';

/// See also [markdownValue].
final markdownValueProvider = AutoDisposeProvider<String>(
  markdownValue,
  name: r'markdownValueProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$markdownValueHash,
);
typedef MarkdownValueRef = AutoDisposeProviderRef<String>;
