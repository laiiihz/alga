import 'package:devtoys/constants/import_helper.dart';

class RegexTesterProvider extends ChangeNotifier {
  final regexController = TextEditingController();
  final textController = TextEditingController();

  RegExp? get reg {
    if (regexController.text.isEmpty) return null;
    try {
      return RegExp(regexController.text);
    } catch (e) {
      return null;
    }
  }

  update() {
    notifyListeners();
  }

  @override
  void dispose() {
    regexController.dispose();
    textController.dispose();
    super.dispose();
  }
}
