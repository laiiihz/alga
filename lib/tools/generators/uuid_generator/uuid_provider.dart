part of './uuid_generator.dart';

enum UUIDVersion {
  v1,
  v4,
}

extension UUIDExt on UUIDVersion {
  String typeName(BuildContext context) {
    switch (this) {
      case UUIDVersion.v1:
        return '1'.padRight(10);
      case UUIDVersion.v4:
        return '4 (GUID)'.padRight(10);
    }
  }
}

final _uuid = StateProvider.autoDispose((ref) => const Uuid());

final _version =
    StateProvider.autoDispose<UUIDVersion>((ref) => UUIDVersion.v4);
final _hypens = StateProvider.autoDispose<bool>((ref) => true);
final _upperCase = StateProvider.autoDispose<bool>((ref) => true);
final _countController =
    StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _count = StateProvider.autoDispose<int>((ref) {
  return int.tryParse(ref.read(_countController).text) ?? 1;
});

final _results = StateProvider.autoDispose<List<String>>((ref) {
  final uuid = ref.read(_uuid);
  final version = ref.watch(_version);
  final hypen = ref.watch(_hypens);
  final uppercase = ref.watch(_upperCase);
  final count = ref.watch(_count);

  String genId() {
    switch (version) {
      case UUIDVersion.v1:
        return uuid.v1();
      case UUIDVersion.v4:
        return uuid.v4();
    }
  }

  String convertValue() {
    String value = genId();
    if (!hypen) value = value.replaceAll('-', '');
    if (uppercase) value = value.toUpperCase();
    return value;
  }

  return List.generate(count, (index) => convertValue());
});

final _resultValue =
    StateProvider.autoDispose<String>((ref) => ref.watch(_results).join('\n'));
