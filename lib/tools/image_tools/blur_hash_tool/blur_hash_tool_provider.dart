part of 'blur_hash_tool_view.dart';

Future<ImageItem?> _gen(File file) async {
  return await compute(ImageUtil.getBlurHash, file);
}

final currentFile = StateProvider.autoDispose<File?>((ref) => null);

final blurhashItem = FutureProvider.autoDispose<ImageItem?>((ref) async {
  final currentImage = ref.watch(currentFile);
  if (currentImage == null) return null;
  ImageItem? item = await _gen(currentImage);
  if (item == null) return null;
  return item;
});

final hashController = Provider.autoDispose((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final hashText = Provider.autoDispose<String?>((ref) {
  final text = ref.watch(hashController).text;
  if (text.isEmpty) return null;
  if (text.length < 6) return null;

  final sizeFlag = _decode83(text[0]);
  final numY = (sizeFlag / 9).floor() + 1;
  final numX = (sizeFlag % 9) + 1;

  if (text.length != 4 + 2 * numX * numY) {
    return null;
  }
  return text;
});

const _digitCharacters =
    "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz#\$%*+,-.:;=?@[]^_{|}~";

/// copy from blurhash
int _decode83(String str) {
  var value = 0;
  final units = str.codeUnits;
  final digits = _digitCharacters.codeUnits;
  for (var i = 0; i < units.length; i++) {
    final code = units.elementAt(i);
    final digit = digits.indexOf(code);
    if (digit == -1) {
      throw ArgumentError.value(str, 'str');
    }
    value = value * 83 + digit;
  }
  return value;
}


// save(BlurHashConfig config, BuildContext context) async {
//   final result = await compute(_save, config);
//   // TODO
//   // ignore: use_build_context_synchronously
//   ScaffoldMessenger.of(context)
//       .showSnackBar(const SnackBar(content: Text('Saved')));
//   return result;
// }

// _save(BlurHashConfig config) async {
//   File file =
//       File(path.join(config.storePath, '${DateTime.now().millisecond}.png'));
//   await file.create();
//   return file.writeAsBytes(config.bytes);
// }
