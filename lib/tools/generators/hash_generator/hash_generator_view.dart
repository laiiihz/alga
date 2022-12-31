import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/hash_generator/hash_provider.dart';

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
              PasteButton(onPaste: (ref, data) {
                ref.watch(inputController).text = data;
                return ref.refresh(hashResults);
              }),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  ref.watch(inputController).clear();
                },
              ),
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
                child: Row(
                  children: [
                    Expanded(child: AppTextField(text: e.result)),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: e.copy,
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
