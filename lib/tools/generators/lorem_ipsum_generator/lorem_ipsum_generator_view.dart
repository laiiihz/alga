import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:flutter/services.dart';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_provider.dart';
import 'package:go_router/go_router.dart';

class LoremIpsumGeneratorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoremIpsumGeneratorView();
  }
}

class LoremIpsumGeneratorView extends ConsumerStatefulWidget {
  const LoremIpsumGeneratorView({super.key});

  @override
  ConsumerState<LoremIpsumGeneratorView> createState() =>
      _LoremIpsumGeneratorViewState();
}

class _LoremIpsumGeneratorViewState
    extends ConsumerState<LoremIpsumGeneratorView> {
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
            ToolViewTextField(
              leading: const Icon(Icons.numbers),
              title: Text(S.of(context).loremLength),
              subtitle: Text(S.of(context).loremLengthDes),
              controller: loremNumberController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onEditingComplete: (ref) => ref.refresh(loremCount),
              hint: '1',
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            CopyButtonWidget(refText: (ref) => ref.watch(loremProvider).output),
            // CopyButton2(loremProvider),
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
