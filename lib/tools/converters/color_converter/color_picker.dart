import 'package:alga/l10n/l10n.dart';
import 'package:alga/utils/theme_util.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class AppColorPicker extends StatefulWidget {
  const AppColorPicker({super.key, required this.color});
  final Color? color;

  static Future<Color?> show(BuildContext context, Color? color) async {
    return await showDialog(
      context: context,
      builder: (context) {
        final isMobile = isSmallDevice(context);
        Widget next = AppColorPicker(color: color);
        if (!isMobile) {
          next = Padding(
            padding: const EdgeInsets.all(64),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: next,
            ),
          );
        }
        return next;
      },
    );
  }

  @override
  State<AppColorPicker> createState() => _AppColorPickerState();
}

class _AppColorPickerState extends State<AppColorPicker> {
  late Color _color = widget.color ?? Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Color'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_color);
            },
            child: Text(context.mtr.okButtonLabel),
          ),
        ],
      ),
      body: ColorPicker(
        color: _color,
        enableOpacity: true,
        onColorChanged: (c) {
          _color = c;
          setState(() {});
        },
        pickersEnabled: {for (final i in ColorPickerType.values) i: true},
        pickerTypeLabels: {
          for (final i in ColorPickerType.values) i: i.getName(context)
        },
      ),
    );
  }
}

extension on ColorPickerType {
  String getName(BuildContext context) {
    return switch (this) {
      ColorPickerType.both => context.tr.colorBoth,
      ColorPickerType.primary => context.tr.colorPrimary,
      ColorPickerType.accent => context.tr.colorAccent,
      ColorPickerType.bw => context.tr.colorBw,
      ColorPickerType.custom => context.tr.colorCustom,
      ColorPickerType.wheel => context.tr.colorWheel,
    };
  }
}
