import 'package:alga/constants/import_helper.dart';
import 'package:flutter_js/flutter_js.dart';

part './quick_js_provider.dart';

class QuickJsView extends StatelessWidget {
  const QuickJsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('Quick JS Tool'),
      children: [
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            Consumer(builder: (context, ref, _) {
              return IconButton(
                onPressed: () {
                  ref.refresh(_result);
                },
                icon: const Icon(Icons.paste),
              );
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return LangTextField(
              controller: ref.watch(_input),
              lang: LangHighlightType.js,
              minLines: 2,
              maxLines: 12,
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              data: ref.watch(_result),
            );
          }),
        ),
      ],
    );
  }
}
