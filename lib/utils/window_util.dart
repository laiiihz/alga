import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';

class WindowUtil {
  static Future init() async {
    if (kIsWeb) {
      return;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return;
    } else {
      await windowManager.ensureInitialized();
      windowManager.waitUntilReadyToShow().then((value) async {
        await windowManager.setTitleBarStyle('hidden',
            windowButtonVisibility: false);
        await windowManager.center();
        await windowManager.setTitle('Alga');
        await windowManager.setSkipTaskbar(false);
        await windowManager.show();
      });
    }
  }

  static setTitle(String title) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) return;
    await windowManager.setTitle(title);
  }

  static bool get isMobileDevice {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }
}
