import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/hash_generator/hash_provider.dart';
import 'package:alga/widgets/clear_button_widget.dart';
import 'package:alga/widgets/copy_button_widget.dart';
import 'package:alga/widgets/paste_button_widget.dart';

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
            ToolViewSwitchConfig(
              leading: const Icon(Icons.text_fields),
              title: Text(S.of(context).upperCase),
              value: (ref) => ref.watch(hashUpperCase),
              onChanged: (value, ref) =>
                  ref.read(hashUpperCase.notifier).state = value,
            ),
            ToolViewSwitchConfig(
              title: Text(S.of(context).hashHMAC),
              subtitle: Text(S.of(context).hashHMACDes),
              value: (ref) => ref.watch(showHmac),
              onChanged: (value, ref) =>
                  ref.read(showHmac.notifier).state = value,
            ),
          ],
        ),
        Consumer(builder: (context, ref, _) {
          return AppTitleWrapper(
            title: S.of(context).input,
            actions: [
              PasteButtonWidget(ref.watch(inputController)),
              ClearButtonWidget(ref.watch(inputController)),
            ],
            child: TextField(
              minLines: 2,
              maxLines: 12,
              controller: ref.watch(inputController),
              onChanged: (text) {
                return ref.refresh(hashResults);
              },
            ),
          );
        }),
        Consumer(builder: (context, ref, _) {
          if (!ref.watch(showHmac)) return const SizedBox.shrink();
          return AppTitleWrapper(
            title: S.of(context).hashOptional,
            actions: [],
            child: Consumer(builder: (context, ref, _) {
              if (!ref.watch(showHmac)) return const SizedBox.shrink();
              return TextField(
                minLines: 1,
                maxLines: 12,
                controller: ref.watch(optionalController),
                onChanged: (text) {
                  return ref.refresh(hashResults);
                },
              );
            }),
          );
        }),
        Consumer(builder: (context, ref, _) {
          return Column(
            children: ref.watch(hashResults).map((e) {
              return AppTitleWrapper(
                title: e.title(context),
                actions: [
                  CopyButtonWidget(text: e.result),
                ],
                child: AppTextField(text: e.result),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
