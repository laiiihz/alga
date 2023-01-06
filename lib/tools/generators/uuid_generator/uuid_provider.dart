part of './uuid_generator.dart';

enum UUIDVersion {
  v1,
  v4,
  v5,
}

extension UUIDExt on UUIDVersion {
  String typeName(BuildContext context) {
    switch (this) {
      case UUIDVersion.v1:
        return 'V1';
      case UUIDVersion.v4:
        return 'V4 (GUID)';
      case UUIDVersion.v5:
        return 'V5';
    }
  }
}

final _uuid = StateProvider.autoDispose((ref) => const Uuid());

final _version =
    StateProvider.autoDispose<UUIDVersion>((ref) => UUIDVersion.v4);
final _hypens = StateProvider.autoDispose<bool>((ref) => true);
final _upperCase = StateProvider.autoDispose<bool>((ref) => true);

final _countController = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _v5NameController = Provider.autoDispose((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _v5NamespaceController = Provider.autoDispose((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _count = StateProvider.autoDispose<int>((ref) {
  int result = int.tryParse(ref.watch(_countController).text) ?? 1;
  if (result > 2000) result = 2000;
  return result;
});

final _v5Name = Provider.autoDispose((ref) {
  return ref.watch(_v5NameController).text;
});
final _v5Namespace = Provider.autoDispose<String?>((ref) {
  final text = ref.watch(_v5NamespaceController).text;
  final regex = RegExp(r'^[a-fA-F0-9]{32}$');
  final fullRegex = RegExp(
      r'^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$');
  if (regex.hasMatch(text) || fullRegex.hasMatch(text)) {
    return text;
  } else {
    return null;
  }
});

final _results = Provider.autoDispose<String>((ref) {
  final uuid = ref.watch(_uuid);
  final version = ref.watch(_version);
  final hypen = ref.watch(_hypens);
  final uppercase = ref.watch(_upperCase);
  final count = ref.watch(_count);
  final v5NameText = ref.watch(_v5Name);
  final v5NamespaceText = ref.watch(_v5Namespace);
  if (version == UUIDVersion.v5) return uuid.v5(v5NamespaceText, v5NameText);

  String genId() {
    switch (version) {
      case UUIDVersion.v1:
        return uuid.v1();
      case UUIDVersion.v4:
        return uuid.v4();
      default:
        return '';
    }
  }

  String convertValue() {
    String value = genId();
    if (!hypen) value = value.replaceAll('-', '');
    if (uppercase) value = value.toUpperCase();
    return value;
  }

  return List.generate(count, (index) => convertValue()).join('\n');
});
