import 'package:alga/models/app_atom.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteBox {
  static Box<String> get _box => HiveUtil.favoriteBox;

  static Future put(AppAtom atom) async {
    await _box.put(atom.path, atom.path);
  }

  static Future remove(AppAtom atom) async {
    await _box.delete(atom.path);
  }

  static bool get(AppAtom atom) {
    return _box.get(atom.path) != null;
  }

  static Future update(AppAtom atom) async {
    final state = get(atom);
    if (state) {
      await remove(atom);
    } else {
      await put(atom);
    }
  }

  static List<AppAtom> get items {
    final keys = _box.keys;
    final result = <AppAtom>[];
    for (var element in AppAtom.items) {
      if (keys.contains(element.path)) {
        result.add(element);
      }
    }
    return result;
  }

  static ValueListenable<Box<String>> get listenerAll => _box.listenable();
  static ValueListenable<Box<String>> listener(String key) =>
      _box.listenable(keys: [key]);
}
