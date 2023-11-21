import 'dart:convert';
import 'dart:io';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:alga/utils/image_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future _showBase64ImagePicker(BuildContext context) async {
  final file = await ImageUtil.pick();
  if (file == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('empty image')));
    }
    return;
  }

  if (!context.mounted) return;

  return await showDialog(
    context: context,
    builder: (context) {
      return FutureBuilder<String>(
        future: _computeEncode(file),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            final data = snap.data ?? '';
            return AlertDialog(
              title: const Text('Base64 from Image'),
              content: data.length > 1000
                  ? const Text('content is too big')
                  : AppTextField(text: data, minLines: 1, maxLines: 12),
              actions: [
                TextButton(
                  onPressed: () async {
                    await ClipboardUtil.copy(data);
                    if (context.mounted) Navigator.pop(context);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('copy success')));
                    }
                  },
                  child: Text(context.tr.copy),
                ),
              ],
            );
          } else {
            return const SimpleDialog(
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
        },
      );
    },
  );
}

Future<String> _computeEncode(File file) async {
  return await compute(_encode2Base64, file);
}

Future<String> _encode2Base64(File file) async {
  final bytes = file.readAsBytesSync();
  return const Base64Encoder.urlSafe().convert(bytes);
}

class Base64ImageButton extends StatelessWidget {
  const Base64ImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: const Icon(Icons.image),
      onPressed: () {
        _showBase64ImagePicker(context);
      },
      tooltip: '',
    );
  }
}
