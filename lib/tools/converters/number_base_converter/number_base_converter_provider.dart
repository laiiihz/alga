part of './number_base_converter_view.dart';

final _controllers =
    StateProvider.autoDispose<List<NumberBaseController>>((ref) {
  final controllers = [
    HexController(),
    DecController(),
    OctController(),
    BinController(),
  ];
  ref.onDispose(() {
    for (var item in controllers) {
      item.dispose();
    }
  });
  return controllers;
});

class NumberBaseUtil {
  static update(
      NumberBaseController base, List<NumberBaseController> controllers) {
    for (var item in controllers) {
      if (item.runtimeType != base.runtimeType) {
        item.controller.text = base.radixString(item.radix) ?? '';
      }
    }
  }
}

abstract class NumberBaseController {
  final int radix;
  final int maxLength;
  final List<TextInputFormatter> formatter = [];

  /// get l10n title
  String title(BuildContext context);

  NumberBaseController(this.radix, this.maxLength);

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
  HexController() : super(16, 15);

  @override
  String title(context) => S.of(context).hexdecimal;
  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]'))];
}

class DecController extends NumberBaseController {
  DecController() : super(10, 18);

  @override
  String title(context) => S.of(context).decimal;

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.digitsOnly];
}

class OctController extends NumberBaseController {
  OctController() : super(8, 20);

  @override
  String title(context) => S.of(context).octal;

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-8]'))];
}

class BinController extends NumberBaseController {
  BinController() : super(2, 60);

  @override
  String title(context) => S.of(context).binary;

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-1]'))];
}
