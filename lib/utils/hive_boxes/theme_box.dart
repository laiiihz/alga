import 'package:alga/utils/hive_adapters/theme_mode_adapter.dart';
import 'package:alga/utils/hive_util.dart';

class ThemeBox {
  static final _current = HiveUtil.themeBox;
  static ThemeModeModel get themeMode {
    final modeModel = _current.get('themeMode');
    if (modeModel == null) {
      return ThemeModeModel(theThemeMode: ThemeMode.system);
    }
    return modeModel;
  }

  static setThemeMode(ThemeModeModel model) async {
    await _current.put('themeMode', model);
  }
}
