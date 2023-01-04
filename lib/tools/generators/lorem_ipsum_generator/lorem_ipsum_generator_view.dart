import 'package:alga/widgets/copy_button_widget.dart';
import 'package:alga/widgets/custom_icon_button.dart';
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
            ToolViewMenuConfig<LoremIpsumType>(
              name: (ref) => ref.watch(loremType).typeName(context),
              leading: const Icon(Icons.text_snippet),
              title: Text(S.of(context).loremType),
              subtitle: Text(S.of(context).loremTypeDes),
              items: LoremIpsumType.values
                  .map((e) => PopupMenuItem(
                        value: e,
                        child: Text(e.typeName(context)),
                      ))
                  .toList(),
              initialValue: (ref) => ref.watch(loremType),
              onSelected: (type, ref) {
                final typeData = ref.read(loremType.notifier);
                typeData.state = type;
              },
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
            CopyButtonWidget(refText: (ref) => ref.watch(loremProvider).output),
            Consumer(
              builder: (context, ref, _) {
                return CustomIconButton(
                  tooltip: context.tr.refresh,
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
              return AppTextField(
                text: ref.watch(loremProvider).output,
                minLines: 2,
                maxLines: null,
              );
            },
          ),
        ),
      ],
    );
  }
}
