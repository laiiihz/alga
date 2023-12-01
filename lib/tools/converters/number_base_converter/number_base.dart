import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberBasePage extends ConsumerStatefulWidget {
  const NumberBasePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NumberBasePageState();
}

class _NumberBasePageState extends ConsumerState<NumberBasePage> {
  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      title: Text(context.tr.numberBaseConverter),
      children: [],
    );
  }
}
