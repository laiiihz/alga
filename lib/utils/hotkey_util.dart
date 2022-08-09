import 'dart:io';

import 'package:alga/routers/app_router.dart';
import 'package:alga/views/search_view.dart';
import 'package:flutter/foundation.dart';

import 'package:hotkey_manager/hotkey_manager.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:window_manager/window_manager.dart';

class HotkeyUtil extends WindowListener {
  static HotkeyUtil? instance;
  HotkeyUtil._();
  factory HotkeyUtil() => instance ??= HotkeyUtil._();

  static bool _hasSearch = false;
  static String get label {
    if (kIsWeb) return '';
    if (Platform.isMacOS) return '${KeyModifier.meta.keyLabel}+F';
    if (Platform.isWindows) return '${KeyModifier.control.keyLabel}+F';
    return '';
  }

  init() async {
    WindowManager.instance.addListener(this);
  }

  @override
  void onWindowBlur() {
    hotKeyManager.unregisterAll();
  }

  @override
  void onWindowFocus() {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) return;
    late HotKey key;
    if (Platform.isWindows) {
      key = HotKey(KeyCode.keyF, modifiers: [KeyModifier.control]);
    } else if (Platform.isMacOS) {
      key = HotKey(KeyCode.keyF, modifiers: [KeyModifier.meta]);
    } else if (Platform.isLinux) {
      key = HotKey(KeyCode.keyF, modifiers: [KeyModifier.control]);
    } else {
      throw UnimplementedError('Platform unsupported');
    }
    hotKeyManager.unregisterAll();
    hotKeyManager.register(
      key,
      keyDownHandler: (hotKey) {
        if (!_hasSearch) {
          _hasSearch = true;
          showAlgaSearch(gcontext).then((_) {
            _hasSearch = false;
          });
        } else {
          Navigator.pop(gcontext);
        }
      },
      keyUpHandler: (key) {},
    );
  }
}
