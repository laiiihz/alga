import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_provider.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoremIpsumGeneratorView extends StatelessWidget {
  const LoremIpsumGeneratorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).generatorLoremIpsum),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              leading: const Icon(Icons.text_snippet),
              title: const Text('Type'),
              subtitle: const Text(
                  'Generate words,sentences or paragraphs of Lorem ipsum'),
              trailing: Consumer(
                builder: (context, ref, _) {
                  return DropdownButton<LoremIpsumType>(
                    underline: const SizedBox.shrink(),
                    items: LoremIpsumType.values
                        .map((e) => DropdownMenuItem(
                              child: Text(e.typeName(context)),
                              value: e,
                            ))
                        .toList(),
                    value: ref.watch(loremType),
                    onChanged: (LoremIpsumType? type) {
                      final _type = ref.read(loremType.notifier);
                      _type.state = type ?? LoremIpsumType.words;
                    },
                  );
                },
              ),
            ),
            ToolViewConfig(
              leading: const Icon(Icons.numbers),
              title: const Text('Length'),
              subtitle: const Text(
                  'Number of words,sentences or paragraphs to generate'),
              trailing: SizedBox(
                width: 60,
                child: Consumer(builder: (context, ref, _) {
                  return TextField(
                    controller: ref.watch(loremNumberController),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) {
                      final value =
                          int.tryParse(ref.watch(loremNumberController).text);
                      ref.read(loremCount.notifier).state = value ?? 1;
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            Consumer(
              builder: (context, ref, _) {
                return ref.watch(loremProvider).when(
                      data: (state) => IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () async {
                          ClipboardUtil.copy(state.output);
                        },
                      ),
                      error: (err, stack) => Text(err.toString()),
                      loading: () => const CircularProgressIndicator(),
                    );
              },
            ),
            Consumer(
              builder: (context, ref, _) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    ref.refresh(loremProvider);
                  },
                );
              },
            ),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              return ref.watch(loremProvider).when(
                    data: (state) => AppTextBox(
                      data: state.output,
                      minLines: 2,
                      maxLines: null,
                    ),
                    error: (err, stack) => Text(err.toString()),
                    loading: () => const CircularProgressIndicator(),
                  );
            },
          ),
        ),
      ],
    );
  }
}
