import 'package:alga/tools/text_tools/markdown_preview/markdown_view_provider.dart';
import 'package:alga/utils/snackbar_util.dart';
import 'package:alga/widgets/app_scaffold.dart';
import 'package:alga/widgets/clear_button_widget.dart';
import 'package:alga/widgets/copy_button_widget.dart';
import 'package:alga/widgets/custom_icon_button.dart';
import 'package:alga/widgets/paste_button_widget.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:markdown/markdown.dart' as m_down;
import 'package:url_launcher/url_launcher_string.dart';

class MarkdownPreviewView extends ConsumerStatefulWidget {
  const MarkdownPreviewView({super.key});

  @override
  ConsumerState<MarkdownPreviewView> createState() =>
      _MarkdownPreviewViewState();
}

class _MarkdownPreviewViewState extends ConsumerState<MarkdownPreviewView> {
  @override
  Widget build(BuildContext context) {
    final bool small = isSmallDevice(context);
    final editable = AppTitleWrapper(
      title: S.of(context).markdownInput,
      expand: !small,
      actions: [
        PasteButtonWidget(markdownControllerProvider),
        ClearButtonWidget(markdownControllerProvider),
      ],
      child: TextField(
        expands: !small,
        maxLines: small ? 16 : null,
        minLines: small ? 16 : null,
        textAlignVertical: TextAlignVertical.top,
        controller: ref.watch(markdownControllerProvider),
      ),
    );
    final preview = AppTitleWrapper(
      title: S.of(context).markdownPreviewInput,
      expand: !small,
      actions: [
        CopyButton2(markdownControllerProvider),
        CustomIconButton(
          tooltip: context.tr.copyHtml,
          onPressed: () async {
            final text = ref.read(markdownValueProvider);
            if (text.isEmpty) {
              SnackbarUtil(context).fail('Empty Text');
            } else {
              await ClipboardUtil.copy(m_down.markdownToHtml(text));
              if (mounted) SnackbarUtil(context).copied();
            }
          },
          icon: const Icon(Icons.copy_all_rounded),
        ),
      ],
      child: Consumer(builder: (context, ref, _) {
        final data = ref.watch(markdownValueProvider);
        void onTapLink(text, href, title) {
          if (href != null) {
            launchUrlString(
              href,
              mode: LaunchMode.externalApplication,
            );
          }
        }

        if (isSmallDevice(context)) {
          return MarkdownBody(
            data: data,
            selectable: true,
            onTapLink: onTapLink,
          );
        } else {
          return Markdown(
            data: data,
            selectable: true,
            onTapLink: onTapLink,
          );
        }
      }),
    );

    return AppScaffold(
      title: Text(context.tr.markdownPreview),
      first: editable,
      second: preview,
    );
  }
}
