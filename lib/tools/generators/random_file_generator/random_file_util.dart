part of './random_file_generator_view.dart';

class RandomFileChunk {
  /// 4MB chunk size
  static const int chunkSize = 1024 * 1024 * 4;
  final List<int> chunkList;

  RandomFileChunk._(this.chunkList);
  factory RandomFileChunk.gen(int size) =>
      RandomFileChunk._(_genChunkList(size));

  static List<int> _genChunkList(int size) {
    if (size < chunkSize) return [size];
    int length = size ~/ chunkSize;
    final result = List.generate(length, (index) => chunkSize);
    if (length + 0.0 != size / chunkSize) {
      result.add(size % chunkSize);
    }
    return result;
  }
}

class RandomFile {
  final RandomFileChunk chunk;
  final String path;

  RandomFile({
    required int size,
    required this.path,
  }) : chunk = RandomFileChunk.gen(size);
}

_genRandomFile(RandomFile file) async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(_genRandomFileComputed, [receivePort.sendPort, file]);
  return await receivePort.first;
}

_genRandomFileComputed(List<Object> items) async {
  final sendPort = items[0] as SendPort;
  final randomFile = items[1] as RandomFile;
  final storeFile = File(randomFile.path);
  if (!await storeFile.exists()) {
    await storeFile.create();
  }

  final sink = storeFile.openWrite();
  for (var item in randomFile.chunk.chunkList) {
    sink.add(List.generate(item, (i) => 0));
    await sink.flush();
  }

  sink.close();

  sendPort.send(null);
}
