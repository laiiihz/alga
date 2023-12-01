import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/converters/color_converter/color_picker.dart';
import 'package:alga/tools/converters/color_converter/color_view_background_patiner.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pigment/pigment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_converter.provider.dart';
part 'color_converter.g.dart';

final _useContent = stringConfigProvider(const Key('use_content'));

class ColorConverterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ColorConverterPage();
  }
}

class ColorConverterPage extends ConsumerStatefulWidget {
  const ColorConverterPage({super.key});

  @override
  ConsumerState<ColorConverterPage> createState() => _ColorConverterPageState();
}

class _ColorConverterPageState extends ConsumerState<ColorConverterPage> {
  final _controller = TextEditingController();
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
    final result = ref.watch(resultProvider);
    return ScrollableScaffold(
      title: Text(context.tr.colorConverter),
      children: [
        AlgaToolbar(
          title: Text(context.tr.input),
          actions: [
            CustomIconButton(
              tooltip: 'Pick Color',
              onPressed: () async {
                final color = await AppColorPicker.show(context, null);
                if (color == null) return;
                if (!mounted) return;
                _controller.text =
                    '0x${color.value.toRadixString(16).padLeft(8)}';
              },
              icon: const Icon(Icons.palette_rounded),
            ),
          ],
        ),
        AppInput(
          controller: _controller,
          decoration: InputDecoration(errorText: result.$2),
        ),
        CrossFade(
          state: result.$1 != null,
          first:
              ColorResultWidget(result.$1 ?? ColorResult(Colors.transparent)),
        ),
      ],
    );
  }
}

class ColorResultWidget extends StatelessWidget {
  const ColorResultWidget(this.result, {super.key});

  final ColorResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AlgaToolbar(
          title: Text(context.tr.currentColor),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CustomPaint(
            painter: ColorViewBackgroundPainter(
                Theme.of(context).colorScheme.onBackground),
            child: Material(
              color: result.color,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    Chip(
                      label: Text('Red: ${result.color.red}'),
                      backgroundColor: Colors.red.withOpacity(0.2),
                    ),
                    Chip(
                      label: Text('Green: ${result.color.green}'),
                      backgroundColor: Colors.green.withOpacity(0.2),
                    ),
                    Chip(
                      label: Text('Blue: ${result.color.blue}'),
                      backgroundColor: Colors.blue.withOpacity(0.2),
                    ),
                    Chip(label: Text('Alpha: ${result.color.alpha}')),
                    Chip(
                      label: Text(
                        'Opacity: ${result.color.opacity.toStringAsFixed(3)}',
                      ),
                    ),
                    Chip(
                      label: Text('Hue: ${result.hsl.hue.toStringAsFixed(3)}'),
                    ),
                    Chip(
                      label: Text(
                          'Saturation: ${result.hsl.saturation.toStringAsFixed(3)}'),
                    ),
                    Chip(
                      label: Text(
                          'Lightness: ${result.hsl.lightness.toStringAsFixed(3)}'),
                    ),
                    Chip(
                      label:
                          Text('Value: ${result.hsv.value.toStringAsFixed(3)}'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <String, String>{
            'CSS-RGB': result.cssRGB,
            'CSS-HEX': result.cssHex,
            'CSS-HSL': result.cssHSL,
            'Flutter Hex': result.flutterHex,
          }.entries.map((e) {
            return ElevatedButton.icon(
              onPressed: () {
                ClipboardUtil.copy(e.value);
              },
              icon: Text(e.key),
              label: Text(e.value),
            );
          }).toList(),
        ),
      ].sep(const SizedBox(height: 4)),
    );
  }
}
