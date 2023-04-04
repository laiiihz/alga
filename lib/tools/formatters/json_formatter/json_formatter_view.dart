import 'package:alga/tools/formatters/json_formatter/json_provider.dart';
import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:alga/utils/constants/import_helper.dart';

import 'json_enums.dart';

class JsonFormatterView extends StatelessWidget {
  const JsonFormatterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ToolView(
      title: Text(context.tr.formatterJson),
      content: ToolbarView(
        configs: [
          ToolViewMenuConfig<JsonIndentType>(
            leading: const Icon(Icons.space_bar_rounded),
            title: Text(context.tr.indentation),
            initialValue: (ref) => ref.read(jsonIndentProvider),
            items: JsonIndentType.values
                .map((e) =>
                    PopupMenuItem(value: e, child: Text(e.name(context))))
                .toList(),
            onSelected: (type, ref) {
              ref.read(jsonIndentProvider.notifier).update(type);
            },
            name: (ref) => ref.watch(jsonIndentProvider).name(context),
          ),
        ],
        inputWidget: Consumer(builder: (context, ref, _) {
          return TextField(
            minLines: 80,
            maxLines: 100,
            controller: ref.watch(rawJsonControllerProvider),
          );
        }),
        outputWidget: Consumer(builder: (context, ref, _) {
          return AppTextField(
            minLines: 80,
            maxLines: 100,
            language: HighlightType.json,
            text: ref.watch(formattedJsonControllerProvider).result ?? '',
          );
        }),
        inputActions: [
          PasteButtonWidget(rawJsonControllerProvider),
          ClearButtonWidget(rawJsonControllerProvider),
        ],
        outputActions: [
          Consumer(builder: (context, ref, _) {
            return CopyButtonWithText.raw(
              ref.watch(formattedJsonControllerProvider).result,
            );
          }),
        ],
      ),
    );
  }
}
