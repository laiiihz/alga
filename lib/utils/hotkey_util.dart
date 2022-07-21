import 'dart:io';

import 'package:alga/views/search_view.dart';
import 'package:flutter/foundation.dart';

import 'package:hotkey_manager/hotkey_manager.dart';

import 'package:alga/constants/import_helper.dart';

class HotkeyUtil {
  static bool _hasSearch = false;
  static String get label {
    if (kIsWeb) return '';
    if (Platform.isMacOS) return '${KeyModifier.meta.keyLabel}+F';
    if (Platform.isWindows) return '${KeyModifier.control.keyLabel}+F';
    return '';
  }

  static init(BuildContext context) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) return;
    late HotKey key;
    if (Platform.isWindows) {
      key = HotKey(KeyCode.keyF, modifiers: [KeyModifier.control]);
    } else if (Platform.isMacOS) {
      key = HotKey(KeyCode.keyF, modifiers: [KeyModifier.meta]);
    } else if (Platform.isLinux) {
      //TODO linux implement
    } else {
      throw UnimplementedError('Platform unsupported');
    }
    await hotKeyManager.unregisterAll();
    await hotKeyManager.register(
      key,
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
