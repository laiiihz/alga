import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/error_message_expandable.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:language_textfield/language_textfield.dart';

class DartFormatterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DartFormatterPage();
  }
}

class DartFormatterPage extends ConsumerStatefulWidget {
  const DartFormatterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DartFormatterPageState();
}

class _DartFormatterPageState extends ConsumerState<DartFormatterPage> {
  final RichTextController controller =
      RichTextController.lang(type: HighlightType.dart);
  final _loading = ValueNotifier(false);
  final _errorMessage = ValueNotifier<String?>(null);

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
        title: Text(context.tr.formatterDart),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AlgaToolbar(
              title: ValueListenableBuilder(
                valueListenable: _loading,
                builder: (context, state, child) {
                  return CrossFade(
                    state: !state,
                    first: const Text('Dart'),
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
      final result = await compute(_format, text);
      controller.text = result.$1;
      _errorMessage.value = result.$2;
      _loading.value = false;
    } else {
      final result = _format(text);
      controller.text = result.$1;
      _errorMessage.value = result.$2;
    }
  }
}

(String, String?) _format(String text) {
  try {
    return (DartFormatter().format(text), null);
  } catch (e) {
    return (text, e.toString());
  }
}
