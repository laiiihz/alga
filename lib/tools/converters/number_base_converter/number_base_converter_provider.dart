import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/services.dart';

class NumberBaseConverterProvider extends ChangeNotifier {
  List<NumberBaseController> controllers = [
    HexController(),
    DecController(),
    OctController(),
    BinController(),
  ];

  onUpdate(NumberBaseController controller) {
    for (var item in controllers) {
      if (item.runtimeType != controller.runtimeType) {
        item.controller.text = controller.radixString(item.radix) ?? '';
      }
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

abstract class NumberBaseController {
  final int radix;
  final String title = '';
  final List<TextInputFormatter> formatter = [];
  NumberBaseController(this.radix);

  final controller = TextEditingController();
  int? get value => int.tryParse(controller.text, radix: radix);
  String? radixString(int radix) {
    if (value == null) return null;
    return value!.toRadixString(radix);
  }

  copy() {
    ClipboardUtil.copy(controller.text);
  }

  dispose() {
    controller.dispose();
  }
}

class HexController extends NumberBaseController {
  HexController() : super(16);

  @override
  String get title => 'Hexdecimal';
  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]'))];
}

class DecController extends NumberBaseController {
  DecController() : super(10);

  @override
  String get title => 'Decimal';

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.digitsOnly];
}

class OctController extends NumberBaseController {
  OctController() : super(8);

  @override
  String get title => 'Octal';

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-8]'))];
}

class BinController extends NumberBaseController {
  BinController() : super(2);

  @override
  String get title => 'Binary';

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-1]'))];
}
