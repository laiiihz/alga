import 'package:pigment/pigment.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/converters/color_converter/color_view_background_patiner.dart';
import 'package:alga/tools/converters/color_converter/material_color_widget.dart';

part 'color_converter_provider.dart';

class ColorConverterView extends StatelessWidget {
  const ColorConverterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).colorConverter),
      children: [
        AppTitleWrapper(
          title: S.of(context).currentColor,
          actions: [
            HelperIconButton(
              title: const Text('Supported Color Format'),
              content: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: const [
                  Chip(label: Text('CSS Color')),
                  Chip(label: Text('Hex Color')),
                  Chip(label: Text('RGB Color')),
                  Chip(label: Text('Hex Color with Transparency')),
                ],
              ),
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            final lineColor = isDark(context) ? Colors.white54 : Colors.black54;
            return CustomPaint(
              painter: ColorViewBackgroundPainter(lineColor),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ref.watch(_colorProvider),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: lineColor),
                ),
              ),
            );
          }),
        ),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            Consumer(builder: (context, ref, _) {
              return ElevatedButton(
                onPressed: () async {
                  final color = await pickMaterialColor(context);
                  if (color != null) {
                    final hex = color.value & 0xFFFFFF;
                    final opacity = color.value >> 24;
                    ref.watch(_inputController).text =
                        '#${hex.toRadixString(16).padLeft(6, '0')}${opacity.toRadixString(16).padLeft(2)}';
                    ref.refresh(_colorProvider);
                  }
                },
                child: const Text('Material Color'),
              );
            }),
            Consumer(builder: (context, ref, _) {
              return ElevatedButton(
                onPressed: () async {
                  final color = await pickColor(context);
                  if (color != null) {
                    final hex = color.value & 0xFFFFFF;
                    final opacity = color.value >> 24;
                    ref.watch(_inputController).text =
                        '#${hex.toRadixString(16).padLeft(6, '0')}${opacity.toRadixString(16).padLeft(2)}';
                    ref.refresh(_colorProvider);
                  }
                },
                child: const Text('Color'),
              );
            }),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).colorString,
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_inputController),
              onChanged: (_) {
                ref.refresh(_colorProvider);
              },
            );
          }),
        ),
        AppTitleWrapper(
          title: 'Flutter Hex',
          actions: [
            CopyButton(onCopy: (ref) {
              return ref.watch(_hexValue);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              data: ref.watch(_hexValue),
            );
          }),
        ),
        AppTitleWrapper(
          title: 'RGB',
          actions: [
            CopyButton(onCopy: (ref) {
              return ref.watch(_rgbValue);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              data: ref.watch(_rgbValue),
            );
          }),
        ),
        AppTitleWrapper(
          title: 'RGBA',
          actions: [
            CopyButton(onCopy: (ref) {
              return ref.watch(_rgbaValue);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              data: ref.watch(_rgbaValue),
            );
          }),
        ),
        AppTitleWrapper(
          title: 'HSL',
          actions: [
            CopyButton(onCopy: (ref) {
              return ref.watch(_hslValue);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              data: ref.watch(_hslValue),
            );
          }),
        ),
        AppTitleWrapper(
          title: 'HSV',
          actions: [
            CopyButton(onCopy: (ref) {
              return ref.watch(_hsvValue);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              data: ref.watch(_hsvValue),
            );
          }),
        ),
      ],
    );
  }
}
