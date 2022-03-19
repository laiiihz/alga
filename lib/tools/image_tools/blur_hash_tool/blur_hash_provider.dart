part of './blur_hash_view.dart';

final _currentFile =
    StateNotifierProvider.autoDispose<FileState, File?>((ref) => FileState());

final _currentImageItem = FutureProvider.autoDispose<ImageItem?>((ref) {
  final file = ref.watch(_currentFile);
  if (file == null) return null;
  return _gen(file);
});

class FileState extends StateNotifier<File?> {
  FileState() : super(null);

  pick() async {
    state = await ImageUtil.pick();
  }
}

Future<ImageItem?> _gen(File file) async {
  return await compute(ImageUtil.getBlurHash, file);
}

class BlurHashConfig {
  final String hash;
  final Uint8List bytes;
  final int height;
  final int width;
  final String storePath;

  BlurHashConfig._({
    required this.hash,
    required this.bytes,
    required this.height,
    required this.width,
    required this.storePath,
  });
}

Future<BlurHashConfig?> getConfig({
  required BuildContext context,
  required String hash,
  int height = 64,
  int width = 64,
}) async {
  String? _path = await getDirectoryPath();
  if (_path == null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Cancelled')));
    return null;
  }
  final result =
      await blurHashDecodeImage(height: height, width: width, blurHash: hash);
  final bytes = await result.toByteData(format: ui.ImageByteFormat.png);
  if (bytes == null) return null;
  return BlurHashConfig._(
    hash: hash,
    bytes: bytes.buffer.asUint8List(),
    height: height,
    width: width,
    storePath: _path,
  );
}

save(BlurHashConfig config, BuildContext context) async {
  final result = await compute(_save, config);
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Saved')));
  return result;
}

_save(BlurHashConfig config) async {
  File file =
      File(path.join(config.storePath, '${DateTime.now().millisecond}.png'));
  await file.create();
  return file.writeAsBytes(config.bytes);
}
