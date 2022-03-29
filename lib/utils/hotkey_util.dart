import 'dart:io';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/views/search_view/search_view.dart';
import 'package:flutter/foundation.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class HotkeyUtil {
  static init(BuildContext context) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) return;
    await hotKeyManager.unregisterAll();
    HotKey searchHotKey = HotKey(
      KeyCode.keyS,
      modifiers: [KeyModifier.meta],
    );
    await hotKeyManager.register(
      searchHotKey,
      keyDownHandler: (hotKey) {},
      keyUpHandler: (key) {
        showSearch(context: context, delegate: AppSearchDelegate());
      },
    );
  }
}
