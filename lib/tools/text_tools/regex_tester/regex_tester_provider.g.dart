// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regex_tester_provider.dart';

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

String _$regexExpressionHash() => r'a6ef3e819c861246cfbda0b577baf273cac45e5f';

/// can not watch other provider
///
/// Copied from [regexExpression].
final regexExpressionProvider = AutoDisposeProvider<RichTextController>(
  regexExpression,
  name: r'regexExpressionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$regexExpressionHash,
);
typedef RegexExpressionRef = AutoDisposeProviderRef<RichTextController>;
String _$regexValueHash() => r'7539ee314a43a47204dbd70ae9cca09f3af3bffa';

/// See also [regexValue].
final regexValueProvider = AutoDisposeProvider<RegExpValue>(
  regexValue,
  name: r'regexValueProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$regexValueHash,
);
typedef RegexValueRef = AutoDisposeProviderRef<RegExpValue>;
String _$regexInputControllerHash() =>
    r'be7e8dd88c4608abf3398f778e648c56cc9dd3ef';

/// See also [regexInputController].
final regexInputControllerProvider = AutoDisposeProvider<RichTextController>(
  regexInputController,
  name: r'regexInputControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$regexInputControllerHash,
);
typedef RegexInputControllerRef = AutoDisposeProviderRef<RichTextController>;
