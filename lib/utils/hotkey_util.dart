import 'dart:io';

import 'package:alga/constants/import_helper.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class HotkeyUtil {
  static init(BuildContext context) async {
    if (Platform.isAndroid || Platform.isIOS) return;
    await hotKeyManager.unregisterAll();
    HotKey searchHotKey = HotKey(
      KeyCode.keyS,
      modifiers: [KeyModifier.meta],
    );
    await hotKeyManager.register(
      searchHotKey,
      keyDownHandler: (hotKey) {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text('TEST'),
            );
          },
        );
      },
      keyUpHandler: (key) {},
    );
  }
}
