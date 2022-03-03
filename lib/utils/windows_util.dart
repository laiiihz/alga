import 'dart:io';

import 'package:window_manager/window_manager.dart';

class WindowsUtil {
  static Future init() async {
    if (Platform.isAndroid || Platform.isIOS) return;
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow();
    windowManager.center();
  }
}
