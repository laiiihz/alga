import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/hash_generator/hash_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HashGeneratorView extends StatefulWidget {
  const HashGeneratorView({Key? key}) : super(key: key);

  @override
  State<HashGeneratorView> createState() => _HashGeneratorViewState();
}

class _HashGeneratorViewState extends State<HashGeneratorView> {
  List<Widget> controllers2Widgets(List<HashTypeWrapper> controllers) {
    return controllers.map((e) {
      return AppTitleWrapper(
        title: e.title(context),
        actions: const [],
        child: Row(
          children: [
            Expanded(child: TextField(controller: e.controller)),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                e.copy();
              },
            ),
          ],
        ),
      );
    }).toList();
  }

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
              title: const Text('HMAC'),
              subtitle: const Text('Keyed-hash message authentication code'),
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
        AppTitle(
          title: S.of(context).input,
          actions: [
            IconButton(
              icon: const Icon(Icons.paste),
              onPressed: () {
                // _provider.setInputFormClipboard();
              },
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                // _provider.inputController.clear();
              },
            ),
          ],
        ),
        Consumer(builder: (context, ref, _) {
          return TextField(
            minLines: 2,
            maxLines: 12,
            controller: ref.watch(inputController),
            onChanged: (text) {
              ref.refresh(hashResults);
            },
          );
        }),
        Consumer(builder: (context, ref, _) {
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
