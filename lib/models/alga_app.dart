import 'package:alga/l10n/l10n.dart';
import 'package:flutter/material.dart';

typedef ContextBuilder<T> = T Function(BuildContext context);

abstract class AlgaApp {
  const AlgaApp(this.id);

  final int id;
  String title(BuildContext context);
  String description(BuildContext context);
  Widget get icon;
  String get path;

  static const map = <int, AlgaApp>{
    0x01: ABSLengthConverter(),
  };

  static final values = map.values;
  static const unknown = UnknownAlgaApp();
}

class UnknownAlgaApp extends AlgaApp {
  const UnknownAlgaApp() : super(0x00);

  @override
  String description(BuildContext context) => 'NONE';
  @override
  Widget get icon => const Icon(Icons.question_mark);

  @override
  String get path => 'unknown';

  @override
  String title(BuildContext context) => 'UNKNOWN';
}

class ABSLengthConverter extends AlgaApp {
  const ABSLengthConverter() : super(0x01);
  @override
  String description(BuildContext context) =>
      context.tr.absoluteLengthConverter;

  @override
  Widget get icon => const Icon(Icons.legend_toggle);

  @override
  String get path => 'length';

  @override
  String title(BuildContext context) => context.tr.absoluteLengthConverter;
}
