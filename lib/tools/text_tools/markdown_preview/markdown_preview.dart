import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:alga/utils/theme_util.dart';
import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:language_textfield/language_textfield.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:multi_split_view/multi_split_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

final _useContent = stringConfigProvider(const Key('content'));

class MarkdownPreviewRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MarkdownPreview();
  }
}

class MarkdownPreview extends ConsumerStatefulWidget {
  const MarkdownPreview({super.key});

  static TextEditingController controllerOf(BuildContext context) {
    final state = context.findAncestorStateOfType<MarkdownPreviewState>();
    return state!._controller;
  }

  @override
  ConsumerState<MarkdownPreview> createState() => MarkdownPreviewState();
}

class MarkdownPreviewState extends ConsumerState<MarkdownPreview> {
  final _controller = RichTextController.lang(type: HighlightType.markdown);
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref.read(_useContent.notifier).change(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = isSmallDevice(context);
    return isMobile ? const MarkdownMobile() : const MarkdownDesktop();
  }
}

class MarkdownDesktop extends ConsumerWidget {
  const MarkdownDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final controller = MarkdownPreview.controllerOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.markdownPreview),
      ),
      body: MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
          dividerPainter: DividerPainters.grooved1(
            color: scheme.primary,
            highlightedColor: scheme.secondary,
          ),
        ),
        child: MultiSplitView(
          children: [
            MarkdownEditor(controller),
            const MarkdownPreviewWidget(),
          ],
        ),
      ),
    );
  }
}

class MarkdownMobile extends ConsumerStatefulWidget {
  const MarkdownMobile({super.key});

  @override
  ConsumerState<MarkdownMobile> createState() => _MarkdownMobileState();
}

class _MarkdownMobileState extends ConsumerState<MarkdownMobile> {
  bool showPreview = false;
  @override
  Widget build(BuildContext context) {
    final controller = MarkdownPreview.controllerOf(context);
    // ensure cache content
    ref.watch(_useContent);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.markdownPreview),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showPreview = !showPreview;
              });
            },
            icon: showPreview
                ? const Icon(Icons.text_fields_rounded)
                : const Icon(Icons.preview_rounded),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primary, secondary) {
          return SharedAxisTransition(
            animation: primary,
            secondaryAnimation: secondary,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        child: showPreview
            ? const MarkdownPreviewWidget()
            : MarkdownEditor(controller),
      ),
    );
  }
}

class MarkdownEditor extends StatelessWidget {
  const MarkdownEditor(this.controller, {super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AlgaToolbar(
            title: Text(context.tr.markdownInput),
            actions: [
              PasteButton(controller: controller),
              ClearButton(controller: controller),
            ],
          ),
          Expanded(
            child: AppInput(
              controller: controller,
              expands: true,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
        ],
      ),
    );
  }
}

class MarkdownPreviewWidget extends ConsumerWidget {
  const MarkdownPreviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AlgaToolbar(
            title: Text(context.tr.markdownPreviewInput),
            actions: [
              CopyButton(() => ref.read(_useContent)),
              CopyButton(
                () {
                  final content = ref.read(_useContent);
                  return md.markdownToHtml(content);
                },
                icon: const Icon(Icons.html),
              ),
            ],
          ),
          Expanded(
            child: MarkdownContent(ref.watch(_useContent)),
          ),
        ],
      ),
    );
  }
}

class MarkdownContent extends StatelessWidget {
  const MarkdownContent(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) {
    return Markdown(
      selectable: true,
      data: content,
      checkboxBuilder: (state) {
        return Checkbox(
          value: state,
          onChanged: null,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
      imageBuilder: (Uri uri, String? title, String? alt) {
        return Tooltip(
          message: alt,
          child: MarkdownImage(uri.toString()),
        );
      },
      onTapLink: (String text, String? href, String title) {
        if (href != null) {
          launchUrlString(
            href,
            mode: LaunchMode.externalApplication,
          );
        }
      },
    );
  }
}

class MarkdownImage extends StatefulWidget {
  const MarkdownImage(this.url, {super.key});
  final String url;

  @override
  State<MarkdownImage> createState() => _MarkdownImageState();
}

class _MarkdownImageState extends State<MarkdownImage> {
  (Response? response, Object? error) res = (null, null);
  @override
  void initState() {
    super.initState();
    _makeRequest();
  }

  _makeRequest() async {
    try {
      res = (
        await Dio().fetch(RequestOptions(
            path: widget.url, method: 'GET', responseType: ResponseType.bytes)),
        null
      );
    } catch (e) {
      res = (null, e);
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (res.$2 != null) {
      return const Icon(Icons.question_mark_rounded);
    }

    if (res.$1 == null) {
      return const CircularProgressIndicator.adaptive();
    }
    final contentType = res.$1!.headers[Headers.contentTypeHeader].toString();
    if (contentType.toLowerCase().contains('svg')) {
      return SvgPicture.memory(res.$1!.data);
    } else {
      return Image.memory(res.$1!.data);
    }
  }
}
