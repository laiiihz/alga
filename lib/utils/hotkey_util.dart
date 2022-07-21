import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:hotkey_manager/hotkey_manager.dart';

import 'package:alga/constants/import_helper.dart';

class HotkeyUtil {
  static init(BuildContext context) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) return;
    await hotKeyManager.unregisterAll();
    HotKey searchHotKey = HotKey(
      KeyCode.keyS,
      modifiers: [KeyModifier.alt],
    );
    await hotKeyManager.register(
      searchHotKey,
      keyDownHandler: (hotKey) {},
      keyUpHandler: (key) {},
    );
  }
}
