import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/converters/color_converter/color_picker.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pigment/pigment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_converter.provider.dart';
part 'color_converter.g.dart';

final _useContent = stringConfigProvider(const Key('use_content'));

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
        TextField(controller: _controller),
        AlgaToolbar(
          title: Text(context.tr.currentColor),
          actions: [],
        ),
        Material(
          color: result.$1?.color,
          child: SizedBox(
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
