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
