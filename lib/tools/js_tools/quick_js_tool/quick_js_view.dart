import 'package:flutter_js_wrapper/flutter_js_wrapper.dart';

import 'package:alga/constants/import_helper.dart';

part './quick_js_provider.dart';

class QuickJsView extends StatelessWidget {
  const QuickJsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: const Text('Quick JS Tool'),
      children: [
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            PasteButton(
              onPaste: (ref, data) {
                ref.watch(_input).text = data;
                return ref.refresh(_result);
              },
            ),
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
        Consumer(builder: (context, ref, _) {
          return ElevatedButton(
            onPressed: () {
              return ref.refresh(_result);
            },
            child: const Text('RUN'),
          );
        }),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            CopyButton(onCopy: (ref) {
              return ref.watch(_result);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(text: ref.watch(_result));
          }),
        ),
      ],
    );
  }
}
