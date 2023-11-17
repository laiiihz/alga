import 'dart:convert';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/encoders_decoders/uri_parser/urI_parser.provider.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:language_textfield/language_textfield.dart';

final useContent = stringConfigProvider(const Key('content'));

class UriParserRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UriParserPage();
  }
}

class UriParserPage extends ConsumerStatefulWidget {
  const UriParserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UriParserPageState();
}

class _UriParserPageState extends ConsumerState<UriParserPage> {
  // TODO(laiiihz): uri highlight
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref.read(useContent.notifier).change(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(uriProvider);
    final currentUri = result.$1 ?? Uri();
    return ScrollableScaffold(
      title: Text(context.tr.uriParser),
      children: [
        AlgaToolbar(
          title: Text(context.tr.input),
          actions: [
            PasteButton(controller: _controller),
            ClearButton(controller: _controller),
          ],
        ),
        TextField(
          controller: _controller,
          decoration: InputDecoration(errorText: result.$2),
        ),
        CrossFade(
          state: result.$1 != null,
          first: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: <Widget>[
                ...{
                  if (currentUri.hasScheme)
                    context.tr.uriScheme: currentUri.scheme,
                  context.tr.hostName: currentUri.host,
                  if (currentUri.hasPort)
                    context.tr.uriPort: currentUri.port.toString(),
                  context.tr.uriPath: currentUri.path,
                  if (currentUri.hasScheme)
                    context.tr.uriOrigin: currentUri.origin,
                  if (currentUri.hasAuthority)
                    'authority': currentUri.authority,
                }.entries.map((e) {
                  return AppTextField(
                    text: e.value,
                    decoration: InputDecoration(
                      labelText: e.key,
                      suffixIcon: CopyButton(() => e.value),
                    ),
                  );
                }),
                if (currentUri.hasQuery)
                  Builder(builder: (context) {
                    final text = const JsonEncoder.withIndent('  ')
                        .convert(currentUri.queryParameters);
                    return AppTextField(
                      language: HighlightType.json,
                      text: text,
                      decoration: InputDecoration(
                        labelText: context.tr.uriParams,
                        suffixIcon: CopyButton(() => text),
                      ),
                    );
                  }),
              ].sep(const SizedBox(height: 8)),
            ),
          ),
        ),
      ],
    );
  }
}
