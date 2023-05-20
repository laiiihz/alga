import 'package:alga/tools/converters/color_converter/color_converter.provider.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/tools/converters/color_converter/color_view_background_patiner.dart';
import 'package:alga/tools/converters/color_converter/material_color_widget.dart';

class ColorConverterView extends StatelessWidget {
  const ColorConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).colorConverter),
      children: [
        AppTitleWrapper(
          title: S.of(context).currentColor,
          actions:const [
            HelperIconButton(
              title:  Text('Supported Color Format'),
              content: Wrap(
                spacing: 4,
                runSpacing: 4,
                children:  [
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
                duration: kThemeAnimationDuration,
                curve: Curves.easeInOutCubic,
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ref.watch(colorProvider),
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
                    ref.watch(inputControllerProvider).text =
                        '#${hex.toRadixString(16).padLeft(6, '0')}${opacity.toRadixString(16).padLeft(2)}';
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
                    ref.watch(inputControllerProvider).text =
                        '#${hex.toRadixString(16).padLeft(6, '0')}${opacity.toRadixString(16).padLeft(2)}';
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
              controller: ref.watch(inputControllerProvider),
            );
          }),
        ),
        AppTitleWrapper(
          title: 'Flutter Hex',
          actions: [
            CopyButtonWithText(hexValueProvider),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(text: ref.watch(hexValueProvider));
          }),
        ),
        AppTitleWrapper(
          title: 'RGB',
          actions: [
            CopyButtonWithText(rgbProvider),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(text: ref.watch(rgbProvider));
          }),
        ),
        AppTitleWrapper(
          title: 'RGBA',
          actions: [
            CopyButtonWithText(rgbaProvider),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(text: ref.watch(rgbaProvider));
          }),
        ),
        AppTitleWrapper(
          title: 'HSL',
          actions: [
            CopyButtonWithText(hslProvider),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(text: ref.watch(hslProvider));
          }),
        ),
        AppTitleWrapper(
          title: 'HSV',
          actions: [
            CopyButtonWithText(hsvProvider),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(text: ref.watch(hsvProvider));
          }),
        ),
      ],
    );
  }
}
