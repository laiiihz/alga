import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/tools/generators/hash_generator/hash_provider.dart';
import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';

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
              leading: const Icon(Icons.text_fields),
              title: Text(S.of(context).upperCase),
              value: hashUpperCase,
            ),
            AlgaConfigSwitch(
              title: Text(S.of(context).hashHMAC),
              subtitle: Text(S.of(context).hashHMACDes),
              value: showHmac,
            ),
          ],
        ),
        Consumer(builder: (context, ref, _) {
          return AppTitleWrapper(
            title: S.of(context).input,
            actions: [
              PasteButtonWidget(
                inputController,
                onUpdate: (value) => ref.refresh(inputText),
              ),
              ClearButtonWidget(
                inputController,
                onUpdate: (ref) => ref.refresh(inputText),
              ),
            ],
            child: TextField(
              minLines: 2,
              maxLines: 12,
              controller: ref.watch(inputController),
              onChanged: (text) => ref.refresh(inputText),
            ),
          );
        }),
        Consumer(builder: (context, ref, _) {
          if (!ref.watch(showHmac)) return const SizedBox.shrink();
          return AppTitleWrapper(
            title: S.of(context).hashOptional,
            actions: [
              PasteButtonWidget(
                optionalController,
                onUpdate: (ref) => ref.refresh(optionalText),
              ),
              ClearButtonWidget(
                optionalController,
                onUpdate: (ref) => ref.refresh(optionalText),
              ),
            ],
            child: Consumer(builder: (context, ref, _) {
              if (!ref.watch(showHmac)) return const SizedBox.shrink();
              return TextField(
                minLines: 1,
                maxLines: 12,
                controller: ref.watch(optionalController),
                onChanged: (text) => ref.refresh(optionalText),
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
