import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:alga/constants/import_helper.dart';

Future<MaterialColor?> pickMaterialColor(BuildContext context) async {
  return await showDialog<MaterialColor>(
    context: context,
    builder: (context) {
      return const MaterialColorDialog();
    },
  );
}

Future<Color?> pickColor(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return const ColorDialog();
    },
  );
}

class MaterialColorDialog extends StatelessWidget {
  const MaterialColorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colors = Colors.primaries;
    return AlertDialog(
      title: const Text('Material Color'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 3 * 2,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 64,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return MaterialButton(
              onPressed: () {
                Navigator.pop(context, colors[index]);
              },
              color: colors[index],
            );
          },
          itemCount: colors.length,
        ),
      ),
    );
  }
}

class ColorDialog extends StatefulWidget {
  const ColorDialog({Key? key}) : super(key: key);

  @override
  State<ColorDialog> createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  Color _current = Colors.red;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Color'),
      content: ColorPicker(
        pickerColor: _current,
        onColorChanged: (color) {
          setState(() {
            _current = color;
          });
        },
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).confirm),
          onPressed: () => Navigator.of(context).pop(_current),
        ),
      ],
    );
  }
}
