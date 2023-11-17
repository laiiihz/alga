import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _useContent = stringConfigProvider(const Key('content'));

class MarkdownPreview extends StatefulWidget {
  const MarkdownPreview({super.key});

  @override
  State<MarkdownPreview> createState() => MarkdownPreviewState();
}

class MarkdownPreviewState extends State<MarkdownPreview> {
  static of(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final isMobile = isSmallDevice(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.markdownPreview),
      ),
      body: isMobile ? const MarkdownMobile() : const MarkdownDesktop(),
    );
  }
}

class MarkdownDesktop extends ConsumerWidget {
  const MarkdownDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.markdownPreview),
      ),
    );
  }
}

class MarkdownMobile extends ConsumerWidget {
  const MarkdownMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
