import 'dart:io';

import 'package:alga/utils/image_util.dart';
import 'package:flutter/material.dart';

class BlurHashProvider extends ChangeNotifier {
  ImageItem? imageItem;
  Future<bool> gen() async {
    File? file = await ImageUtil.pick();
    if (file == null) return false;
    imageItem = await ImageUtil.getBlurHash(file);
    notifyListeners();
    return imageItem != null;
  }
}
