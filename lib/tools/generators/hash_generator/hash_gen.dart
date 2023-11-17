import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/generators/hash_generator/hash_gen.provider.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final useHmac = booleanConfigProvider(const ValueKey('hmac'));

final useUpperCase =
    booleanConfigProvider(const ValueKey('upperCase'), defaultValue: true);

final useContent = stringConfigProvider(const ValueKey('content'));
final useHmacContent = stringConfigProvider(const ValueKey('hmacContent'));

class HashGenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HashGenPage();
  }
}

class HashGenPage extends ConsumerStatefulWidget {
  const HashGenPage({super.key});

  @override
  ConsumerState<HashGenPage> createState() => _HashGenPageState();
}

class _HashGenPageState extends ConsumerState<HashGenPage> {
  final _input = TextEditingController();
  final _hmac = TextEditingController();

  @override
  void initState() {
    super.initState();
    _input.addListener(() {
      ref.read(useContent.notifier).change(_input.text);
    });
    _hmac.addListener(() {
      ref.read(useHmacContent.notifier).change(_hmac.text);
    });
  }

  @override
  void dispose() {
    _input.dispose();
    _hmac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      title: Text(context.tr.generatorHash),
      configurations: [
        ConfigSwitch(
          leading: const Icon(Icons.shield_outlined),
          title: Text(context.tr.hashHMAC),
          subtitle: Text(context.tr.hashHMACDes),
          value: useHmac,
        ),
        ConfigSwitch(
          leading: const Icon(Icons.text_fields),
          title: Text(context.tr.upperCase),
          value: useUpperCase,
        ),
        ConfigMenu<HashAlg>(
          items: HashAlg.values,
          getName: (t) => t.getName(context),
          title: Text(context.tr.hashAlgorithm),
          initItem: ref.watch(hashAlgorithmProvider),
          onSelect: (t) {
            ref.read(hashAlgorithmProvider.notifier).change(t);
          },
        ),
      ],
      children: [
        AlgaToolbar(
          title: Text(context.tr.input),
          actions: [
            PasteButton(controller: _input),
            ClearButton(controller: _input),
          ],
        ),
        TextField(
          minLines: 1,
          maxLines: 12,
          controller: _input,
        ),
        CrossFade(
          state: ref.watch(useHmac),
          first: TextField(
            minLines: 1,
            maxLines: 12,
            controller: _hmac,
            decoration: const InputDecoration(labelText: 'HMAC'),
          ),
        ),
        AlgaToolbar(
          actions: [
            CopyButton(() => ref.read(resultsProvider)),
          ],
        ),
        AppTextField(text: ref.watch(resultsProvider)),
      ],
    );
  }
}
