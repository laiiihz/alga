import 'dart:io';

import 'package:alga/views/search_view.dart';
import 'package:flutter/foundation.dart';

import 'package:hotkey_manager/hotkey_manager.dart';

import 'package:alga/constants/import_helper.dart';

class HotkeyUtil {
  static bool _hasSearch = false;

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
      keyDownHandler: (hotKey) {
        if (!_hasSearch) {
          _hasSearch = true;
          showAlgaSearch(context).then((_) {
            _hasSearch = false;
          });
        } else {
          Navigator.pop(context);
        }
      },
      keyUpHandler: (key) {},
    );
  }
}
