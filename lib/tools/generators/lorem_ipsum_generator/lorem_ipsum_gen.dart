import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoremIpsumGenPage extends ConsumerStatefulWidget {
  const LoremIpsumGenPage({super.key});

  @override
  ConsumerState<LoremIpsumGenPage> createState() => _LoremIpsumGenPageState();
}

class _LoremIpsumGenPageState extends ConsumerState<LoremIpsumGenPage> {
  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      title: Text(context.tr.generatorLoremIpsum),
    );
  }
}
