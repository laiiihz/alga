import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/abstract/generator_base.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:sass/sass.dart';

class SassCssGeneratorProvider extends GeneratorBase {
  final scssController = TextEditingController();
  final cssController = TextEditingController();

  paste() async {
    scssController.text = await ClipboardUtil.paste();
  }

  @override
  void clear() {
    scssController.clear();
    cssController.clear();
  }

  @override
  void generate() {
    try {
      final result = compileStringToResult(scssController.text);
      cssController.text = result.css;
    } catch (e) {
      cssController.clear();
      return;
    }
  }

  @override
  void dispose() {
    scssController.dispose();
    cssController.dispose();
    super.dispose();
  }
}
