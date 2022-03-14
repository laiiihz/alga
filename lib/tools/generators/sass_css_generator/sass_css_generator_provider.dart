import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/abstract/generator_base.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:sass/sass.dart';

class SassCssGeneratorProvider extends GeneratorBase {
  final scssController = TextEditingController();
  String _cssResult = '';
  String get cssResult => _cssResult;
  set cssResult(String state) {
    _cssResult = state;
    notifyListeners();
  }

  bool _compressResult = false;
  bool get compressResult => _compressResult;
  set compressResult(bool state) {
    _compressResult = state;
    notifyListeners();
  }

  paste() async {
    scssController.text = await ClipboardUtil.paste();
  }

  copy() async {
    ClipboardUtil.copy(cssResult);
  }

  @override
  void clear() {
    scssController.clear();
    cssResult = '';
  }

  @override
  void generate() {
    try {
      final result = compileStringToResult(
        scssController.text,
        style: compressResult ? OutputStyle.compressed : OutputStyle.expanded,
      );
      cssResult = result.css;
    } catch (e) {
      cssResult = '';
      return;
    }
  }

  @override
  void dispose() {
    scssController.dispose();
    super.dispose();
  }
}
