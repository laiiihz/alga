import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/converters/color_converter/color_view_background_patiner.dart';
import 'package:pigment/pigment.dart';

part 'color_converter_provider.dart';

class ColorConverterView extends StatelessWidget {
  const ColorConverterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('Color Converter'),
      children: [
        AppTitleWrapper(
          title: 'Current Color',
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
        AppTitleWrapper(
          title: 'color String',
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_inputController),
              onChanged: (_) {
                ref.refresh(_colorProvider);
              },
            );
          }),
        ),
      ],
    );
  }
}
