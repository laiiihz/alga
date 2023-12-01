import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_gen.provider.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/buttons/refresh_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final useCount = intConfigProvider(const ValueKey('count'));

class LoremIpsumGenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoremIpsumGenPage();
  }
}

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
      configurations: [
        ConfigMenu<LoremIpsumType>(
          leading: const Icon(Icons.text_snippet),
          items: LoremIpsumType.values,
          getName: (t) => t.getName(context),
          title: Text(context.tr.loremType),
          subtitle: Text(context.tr.loremTypeDes),
          initItem: ref.watch(loremTypeProvider),
          onSelect: (t) {
            ref.read(loremTypeProvider.notifier).change(t);
          },
        ),
        ConfigNumber(
          leading: const Icon(Icons.numbers),
          title: Text(context.tr.loremLength),
          subtitle: Text(context.tr.loremLengthDes),
          value: useCount,
        ),
      ],
      fillRemain: Column(
        children: [
          AlgaToolbar(
            actions: [
              CopyButton(() => ref.read(resultsProvider)),
              RefreshButton(() {
                ref.invalidate(resultsProvider);
              }),
            ],
          ),
          Expanded(
            child: AppTextField(
              text: ref.watch(resultsProvider),
              expands: true,
            ),
          ),
        ],
      ),
    );
  }
}
