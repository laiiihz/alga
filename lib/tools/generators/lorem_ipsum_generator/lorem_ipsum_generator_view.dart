import 'package:flutter/services.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_provider.dart';

class LoremIpsumGeneratorView extends StatelessWidget {
  const LoremIpsumGeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).generatorLoremIpsum),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              leading: const Icon(Icons.text_snippet),
              title: Text(S.of(context).loremType),
              subtitle: Text(S.of(context).loremTypeDes),
              trailing: Consumer(
                builder: (context, ref, _) {
                  return DropdownButton<LoremIpsumType>(
                    underline: const SizedBox.shrink(),
                    items: LoremIpsumType.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.typeName(context)),
                            ))
                        .toList(),
                    value: ref.watch(loremType),
                    onChanged: (LoremIpsumType? type) {
                      final typeData = ref.read(loremType.notifier);
                      typeData.state = type ?? LoremIpsumType.words;
                    },
                  );
                },
              ),
            ),
            ToolViewConfig(
              leading: const Icon(Icons.numbers),
              title: Text(S.of(context).loremLength),
              subtitle: Text(S.of(context).loremLengthDes),
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
                    return ref.refresh(loremProvider);
                  },
                );
              },
            ),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              return ref.watch(loremProvider).when(
                    data: (state) => AppTextField(
                      text: state.output,
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
