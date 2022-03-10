import 'package:alga/l10n/l10n.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberBaseConverterProvider extends ChangeNotifier {
  final BuildContext context;
  late List<NumberBaseController> controllers;

  NumberBaseConverterProvider(this.context) {
    controllers = [
      HexController(context),
      DecController(context),
      OctController(context),
      BinController(context),
    ];
  }

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
  final BuildContext context;
  final int radix;
  final String title = '';
  final List<TextInputFormatter> formatter = [];
  NumberBaseController(this.radix, this.context);

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
  HexController(BuildContext context) : super(16, context);

  @override
  String get title => S.of(context).hexdecimal;
  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]'))];
}

class DecController extends NumberBaseController {
  DecController(BuildContext context) : super(10, context);

  @override
  String get title => S.of(context).decimal;

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.digitsOnly];
}

class OctController extends NumberBaseController {
  OctController(BuildContext context) : super(8, context);

  @override
  String get title => S.of(context).octal;

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-8]'))];
}

class BinController extends NumberBaseController {
  BinController(BuildContext context) : super(2, context);

  @override
  String get title => S.of(context).binary;

  @override
  List<TextInputFormatter> get formatter =>
      [FilteringTextInputFormatter.allow(RegExp(r'[0-1]'))];
}
