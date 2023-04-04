import 'package:alga/tools/formatters/dart_formatter/dart_provider.dart';
import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:alga/utils/constants/import_helper.dart';

class DartFormtterView extends StatelessWidget {
  const DartFormtterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ToolView(
      title: Text(context.tr.formatterDart),
      content: ToolbarView(
        configs: const [],
        inputWidget: Consumer(builder: (context, ref, _) {
          return TextField(
            minLines: 80,
            maxLines: 100,
            controller: ref.watch(dartInputProvider),
          );
        }),
        outputWidget: Consumer(builder: (context, ref, _) {
          return AppTextField(
            minLines: 80,
            maxLines: 100,
            language: HighlightType.dart,
            text: ref.watch(resultProvider).result ?? '',
          );
        }),
        inputActions: [
          PasteButtonWidget(dartInputProvider),
          ClearButtonWidget(dartInputProvider),
        ],
        outputActions: [
          Consumer(builder: (context, ref, _) {
            return CopyButtonWithText.raw(
              ref.watch(resultProvider).result,
            );
          }),
        ],
      ),
    );
  }
}
