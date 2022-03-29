import 'package:flutter/material.dart';

import 'package:language_textfield/language_textfield.dart';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/formatters/dart_formatter/dart_provider.dart';
import '../../widgets/formatter_view.dart';

class DartFormtterView extends StatefulWidget {
  const DartFormtterView({Key? key}) : super(key: key);

  @override
  State<DartFormtterView> createState() => _DartFormtterViewState();
}

class _DartFormtterViewState extends State<DartFormtterView> {
  final provider = DartProvider();
  @override
  Widget build(BuildContext context) {
    return FormatterView(
      lang: LangHighlightType.dart,
      title: Text(S.of(context).formatterDart),
      configs: const [],
      onChanged: provider.onChanged,
    );
  }
}
