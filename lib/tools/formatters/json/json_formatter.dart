import 'dart:convert';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/error_message_expandable.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:language_textfield/language_textfield.dart';

class JsonFormatterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const JsonFormatterPage();
  }
}

class JsonFormatterPage extends ConsumerStatefulWidget {
  const JsonFormatterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JsonFormatterPageState();
}

class _JsonFormatterPageState extends ConsumerState<JsonFormatterPage> {
  final RichTextController controller =
      RichTextController.lang(type: HighlightType.json);
  final _loading = ValueNotifier(false);
  final _errorMessage = ValueNotifier<String?>(null);
  JsonIndentType _type = JsonIndentType.space2;

  @override
  void dispose() {
    controller.dispose();
    _loading.dispose();
    _errorMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.formatterJson),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ConfigMenu<JsonIndentType>(
              items: JsonIndentType.values,
              getName: (t) => t.name(context),
              title: Text(context.tr.indentation),
              initItem: _type,
              onSelect: (t) {
                _type = t;
                format();
                setState(() {});
              },
            ),
            AlgaToolbar(
              title: ValueListenableBuilder(
                valueListenable: _loading,
                builder: (context, state, child) {
                  return CrossFade(
                    state: !state,
                    first: Text(context.tr.formatterJson),
                    second: const CircularProgressIndicator.adaptive(),
                  );
                },
              ),
              actions: [
                CopyButton(() => controller.text),
                ToolbarPaste(controller: controller),
                CustomIconButton(
                  tooltip: context.tr.format,
                  onPressed: format,
                  icon: const Icon(Icons.format_indent_decrease_rounded),
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: _errorMessage,
                  builder: (context, message, _) {
                    return TextField(
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      controller: controller,
                      decoration: InputDecoration(
                        error: ErrorMessageWidget.get(message),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> format() async {
    final text = controller.text;
    if (text.length > 2000) {
      _loading.value = true;
      final result = await compute(_format, (text: text, type: _type));
      controller.text = result.$1;
      _errorMessage.value = result.$2;
      _loading.value = false;
    } else {
      final result = _format((text: text, type: _type));
      controller.text = result.$1;
      _errorMessage.value = result.$2;
    }
  }
}

enum JsonIndentType {
  space2('  '),
  space4('    '),
  tab('\t'),
  minified(null),
  ;

  const JsonIndentType(this.indent);

  final String? indent;

  String name(BuildContext context) {
    return switch (this) {
      space2 => S.of(context).json2spaces,
      space4 => S.of(context).json4spaces,
      tab => S.of(context).json1tab,
      minified => S.of(context).jsonMinified,
    };
  }
}

(String, String?) _format(({String text, JsonIndentType type}) input) {
  try {
    final result = JsonEncoder.withIndent(input.type.indent)
        .convert(json.decode(input.text));
    return (result, null);
  } on JsonUnsupportedObjectError catch (e) {
    return (input.text, e.cause.toString());
  } catch (e) {
    return (input.text, e.toString());
  }
}
