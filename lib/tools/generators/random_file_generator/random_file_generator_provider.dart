part of './random_file_generator_view.dart';

enum FileType {
  b,
  kb,
  mb,
  gb,
}

Future<String?> _pickSaveDir() {
  return selector.getDirectoryPath();
}

final _sizeValue = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _sizeType = StateProvider.autoDispose<FileType>((ref) => FileType.kb);

final _fileSize = StateProvider.autoDispose<int>((ref) {
  final sizeValue = ref.watch(_sizeValue).text;
  final sizeType = ref.watch(_sizeType);
  int computedSizeValue = 0;
  if (sizeValue.isNotEmpty) {
    computedSizeValue = int.tryParse(sizeValue) ?? 0;
  }
  int power = 0;
  switch (sizeType) {
    case FileType.b:
      power = 1;
      break;
    case FileType.kb:
      power = 1024;
      break;
    case FileType.mb:
      power = 1024 * 1024;
      break;
    case FileType.gb:
      power = 1024 * 1024 * 1024;
      break;
  }
  return computedSizeValue * power;
});

_genFile(WidgetRef ref, String path) async {
  final fileSize = ref.watch(_fileSize);
  final randomFile = RandomFile(size: fileSize, path: path);
  await _genRandomFile(randomFile);
}
