import 'package:alga/tools/generators/hash_generator/hash_provider.dart';
import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:alga/utils/constants/import_helper.dart';

class HashGeneratorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HashGeneratorView();
  }
}

class HashGeneratorView extends StatefulWidget {
  const HashGeneratorView({super.key});

  @override
  State<HashGeneratorView> createState() => _HashGeneratorViewState();
}

class _HashGeneratorViewState extends State<HashGeneratorView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).generatorHash),
      children: [
        ToolViewWrapper(
          children: [
            AlgaConfigSwitch(
              leading: const Icon(Icons.shield_outlined),
              title: Text(S.of(context).hashHMAC),
              subtitle: Text(S.of(context).hashHMACDes),
              value: showHmac,
            ),
            AlgaConfigSwitch(
              leading: const Icon(Icons.text_fields),
              title: Text(S.of(context).upperCase),
              value: hashUpperCase,
            ),
            ToolViewMenuConfig<HashType>(
              leading: const Icon(Icons.data_object_rounded),
              title: Text(context.tr.hashAlgorithm),
              initialValue: (ref) => ref.watch(hashTypeProvider),
              items: HashType.values
                  .map(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Text(e.typeName(context)),
                    ),
                  )
                  .toList(),
              onSelected: (type, ref) {
                ref.read(hashTypeProvider.notifier).update((state) => type);
              },
              name: (ref) => ref.watch(hashTypeProvider).typeName(context),
            )
          ],
        ),
        Consumer(builder: (context, ref, _) {
          return AppTitleWrapper(
            title: S.of(context).input,
            actions: [
              PasteButtonWidget(inputControllerProvider),
              ClearButtonWidget(inputControllerProvider),
            ],
            child: TextField(
              minLines: 1,
              maxLines: 12,
              controller: ref.watch(inputControllerProvider),
            ),
          );
        }),
        Consumer(builder: (context, ref, _) {
          if (!ref.watch(showHmac)) return const SizedBox.shrink();
          return AppTitleWrapper(
            title: S.of(context).hashSecretkey,
            actions: [
              PasteButtonWidget(saltControllerProvider),
              ClearButtonWidget(saltControllerProvider),
            ],
            child: Consumer(builder: (context, ref, _) {
              if (!ref.watch(showHmac)) return const SizedBox.shrink();
              return TextField(
                minLines: 1,
                maxLines: 12,
                controller: ref.watch(saltControllerProvider),
              );
            }),
          );
        }),
        Consumer(builder: (context, ref, _) {
          final text = ref.watch(hashResultProvider);
          return AppTitleWrapper(
            title: context.tr.output,
            actions: [
              CopyButtonWidget(text: text),
            ],
            child: AppTextField(text: text),
          );
        }),
      ],
    );
  }
}
