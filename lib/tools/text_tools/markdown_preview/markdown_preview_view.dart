import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' show markdownToHtml;

import 'package:alga/constants/import_helper.dart';

part './markdown_preview_provider.dart';

class MarkdownPreviewView extends StatefulWidget {
  const MarkdownPreviewView({Key? key}) : super(key: key);

  @override
  State<MarkdownPreviewView> createState() => _MarkdownPreviewViewState();
}

class _MarkdownPreviewViewState extends State<MarkdownPreviewView> {
  @override
  Widget build(BuildContext context) {
    return ToolView(
      title: Text(S.of(context).markdownPreview),
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTitleWrapper(
                title: S.of(context).markdownInput,
                expand: true,
                actions: [
                  PasteButton(onPaste: (ref, value) {
                    ref.watch(_inputController).text = value;
                    ref.refresh(_inputValue);
                  }),
                ],
                child: Consumer(builder: (context, ref, _) {
                  return LangTextField(
                    expands: true,
                    controller: ref.watch(_inputController),
                    onChanged: (_) {
                      ref.refresh(_inputValue);
                    },
                    lang: LangHighlightType.markdown,
                  );
                }),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTitleWrapper(
                title: S.of(context).markdownPreviewInput,
                actions: [
                  CopyButton(onCopy: (ref) {
                    final data = ref.read(_inputValue);
                    return markdownToHtml(data);
                  }),
                ],
                expand: true,
                child: Consumer(builder: (context, ref, _) {
                  return Markdown(
                    data: ref.watch(_inputValue),
                    selectable: true,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
