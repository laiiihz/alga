import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/hash_generator/hash_provider.dart';

class HashGeneratorView extends StatefulWidget {
  const HashGeneratorView({Key? key}) : super(key: key);

  @override
  State<HashGeneratorView> createState() => _HashGeneratorViewState();
}

class _HashGeneratorViewState extends State<HashGeneratorView> {
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).generatorHash),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              leading: const Icon(Icons.text_fields),
              title: Text(S.of(context).upperCase),
              trailing: Consumer(
                builder: (context, ref, _) {
                  return Switch(
                    value: ref.watch(hashUpperCase),
                    onChanged: (value) {
                      ref.read(hashUpperCase.notifier).state = value;
                    },
                  );
                },
              ),
            ),
            ToolViewConfig(
              title: Text(S.of(context).hashHMAC),
              subtitle: Text(S.of(context).hashHMACDes),
              trailing: Consumer(
                builder: (context, ref, _) {
                  return Switch(
                    value: ref.watch(showHmac),
                    onChanged: (value) {
                      ref.read(showHmac.notifier).state = value;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Consumer(builder: (context, ref, _) {
          return AppTitleWrapper(
            title: S.of(context).input,
            actions: [
              IconButton(
                icon: const Icon(Icons.paste),
                onPressed: () async {
                  ref.watch(inputController).text = await ClipboardUtil.paste();
                },
              ),
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
                ref.refresh(hashResults);
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
                  ref.refresh(hashResults);
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
                actions: const [],
                child: Row(
                  children: [
                    Expanded(child: AppTextBox(data: e.result)),
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
