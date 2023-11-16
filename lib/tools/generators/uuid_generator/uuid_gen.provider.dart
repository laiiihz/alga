import 'package:alga/tools/generators/uuid_generator/uuid_gen.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'uuid_gen.provider.g.dart';

const _uuid = Uuid();

final uuidRegexA = RegExp(r'^[a-fA-F0-9]{32}$');

final uuidRegexB = RegExp(
    r'^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$');

enum UUIDVersion {
  v1,
  v4,
  v5,
  v6,
  v7,
  v8,
  ;

  String getName(BuildContext context) {
    return switch (this) {
      v1 => 'V1',
      v4 => 'V4(GUID)',
      v5 => 'V5',
      v6 => 'V6',
      v7 => 'V7',
      v8 => 'V8',
    };
  }

  String genId(bool uppercase, bool hypens,
      {String? namespace, String? nameV5}) {
    String next = switch (this) {
      v1 => _uuid.v1(),
      v4 => _uuid.v4(),
      v5 => '',
      v6 => _uuid.v6(),
      v7 => _uuid.v7(),
      v8 => _uuid.v8(),
    };
    if (this == UUIDVersion.v5) {
      try {
        next = _uuid.v5(namespace, nameV5);
      } catch (_) {}
    }
    if (uppercase) next = next.toUpperCase();
    if (!hypens) next = next.replaceAll('-', '');
    return next;
  }
}

@riverpod
class UUIDVer extends _$UUIDVer {
  @override
  UUIDVersion build() => UUIDVersion.v4;

  void change(UUIDVersion version) {
    state = version;
  }
}

@riverpod
String results(ResultsRef ref) {
  final hasHypens = ref.watch(hypens);
  final hasUpperCase = ref.watch(uppercase);
  final version = ref.watch(uUIDVerProvider);

  switch (version) {
    case UUIDVersion.v5:
      final name = ref.watch(uuidV5name);
      final namespace = ref.watch(uuidV5namespace);
      return version.genId(
        hasUpperCase,
        hasHypens,
        nameV5: name,
        namespace: namespace,
      );
    default:
      final count = ref.watch(uuidCounts);
      return List.generate(
        count,
        (index) => version.genId(hasUpperCase, hasHypens),
      ).join('\n');
  }
}
