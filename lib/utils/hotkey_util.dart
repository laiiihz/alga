import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:hotkey_manager/hotkey_manager.dart';

import 'package:alga/constants/import_helper.dart';

class HotkeyUtil {
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

  init(BuildContext context) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) return;
    late HotKey key;
    if (Platform.isWindows) {
      key = HotKey(
        KeyCode.keyF,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      );
    } else if (Platform.isMacOS) {
      key = HotKey(
        KeyCode.keyF,
        modifiers: [KeyModifier.meta],
        scope: HotKeyScope.inapp,
      );
    } else if (Platform.isLinux) {
      key = HotKey(
        KeyCode.keyF,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      );
    } else {
      throw UnimplementedError('Platform unsupported');
    }
    await hotKeyManager.unregisterAll();
    await hotKeyManager.register(
      key,
      keyDownHandler: (hotKey) {
        if (!_hasSearch) {
          _hasSearch = true;
        } else {
          Navigator.pop(context);
        }
      },
      keyUpHandler: (key) {},
    );
  }
}
