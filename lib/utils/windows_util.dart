import 'dart:io';

import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

class WindowsUtil {
  static Future init() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );
    } else {
      await windowManager.ensureInitialized();
      await windowManager.waitUntilReadyToShow();
      await windowManager.center();
      await windowManager.setTitle('DevToys');
    }
  }

  static setTitle(String title) async {
    if (Platform.isAndroid || Platform.isIOS) return;
    await windowManager.setTitle(title);
  }
}
