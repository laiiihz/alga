part of './qrcode_view.dart';

final _input = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _inputData =
    StateProvider.autoDispose<String>((ref) => ref.watch(_input).text);

final _versionInput = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _version = StateProvider.autoDispose<int>((ref) {
  final text = ref.watch(_versionInput).text;
  if (text.isEmpty) return QrVersions.auto;
  if (text == 'max') return QrVersions.max;
  if (text == 'min') return QrVersions.min;
  final v = int.tryParse(text);
  if (v == null) return QrVersions.auto;
  bool supported = QrVersions.isSupportedVersion(v);
  if (!supported) return QrVersions.auto;
  return v;
});

final _errorCorrectionLevel =
    StateProvider.autoDispose<int>((ref) => QrErrorCorrectLevel.L);

final _gapless = StateProvider.autoDispose<bool>((ref) => true);
