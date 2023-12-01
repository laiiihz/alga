import 'dart:io';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:file_selector/file_selector.dart' as selector;
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as pub_image;
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pick() async {
    if (kIsWeb) {
      return await _pickDesktop();
    }
    if (Platform.isAndroid || Platform.isIOS) {
      return await _pickMobile();
    }
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      return await _pickDesktop();
    }
    throw UnsupportedError('Unsupported Platform');
  }

  static Future<File?> _pickDesktop() async {
    final file = await selector.openFile(
      acceptedTypeGroups: const [
        selector.XTypeGroup(
          label: 'images',
          extensions: ['jpg', 'jpeg', 'png', 'webp'],
        )
      ],
    );
    if (file == null) return null;
    return File(file.path);
  }

  static Future<File?> _pickMobile() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return null;
    return File(file.path);
  }

  static Future<ImageItem?> getBlurHash(File image) async {
    final data = image.readAsBytesSync();
    final rawImage = pub_image.decodeImage(data);
    if (rawImage == null) return null;
    final blurhash = BlurHash.encode(rawImage);
    return ImageItem(image: rawImage, blurHash: blurhash, file: image);
  }

  // static Future<bool> share(BuildContext captureContext) async {
  //   RenderRepaintBoundary? box =
  //       captureContext.findRenderObject() as RenderRepaintBoundary?;
  //   if (box == null) return false;
  //   final raw = await _widget2image(box);
  //   if (raw == null) return false;
  //   final result = await Share.shareXFiles([
  //     XFile.fromData(raw),
  //   ]);

  //   if (result.status == ShareResultStatus.success) return true;
  //   return false;
  // }
}

class ImageItem {
  final pub_image.Image image;
  final BlurHash blurHash;
  final File file;
  ImageItem({
    required this.image,
    required this.blurHash,
    required this.file,
  });

  double get aspectRatio => image.width / image.height;
}

// Future<Uint8List?> _widget2image(RenderRepaintBoundary boundary) {
//   return compute(_widget2imageCore, boundary);
// }

// Future<Uint8List?> _widget2imageCore(RenderRepaintBoundary boundary) async {
//   final image = await boundary.toImage(pixelRatio: 2);
//   final pngRaw = await image.toByteData(format: ImageByteFormat.png);
//   if (pngRaw == null) return null;
//   return pngRaw.buffer.asUint8List();
// }
