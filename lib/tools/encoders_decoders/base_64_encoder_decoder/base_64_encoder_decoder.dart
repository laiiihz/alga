import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/image_util.dart';

part './base_64_provider.dart';
part './base64_file_picker.dart';

class Base64EncoderDecoderView extends StatefulWidget {
  const Base64EncoderDecoderView({super.key});

  @override
  State<Base64EncoderDecoderView> createState() =>
      _Base64EncoderDecoderViewState();
}

class _Base64EncoderDecoderViewState extends State<Base64EncoderDecoderView> {
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).encoderDecoderBase64),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              leading: const Icon(Icons.swap_horiz_sharp),
              title: Text(S.of(context).conversion),
              subtitle: Text(S.of(context).selectConversion),
              trailing: Consumer(builder: (context, ref, _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ref.watch(_isEncode)
                        ? Text(S.of(context).encode)
                        : Text(S.of(context).decode),
                    Switch(
                      value: ref.watch(_isEncode),
                      onChanged: (state) {
                        ref.read(_isEncode.notifier).state = state;
                      },
                    ),
                  ],
                );
              }),
            ),
            ToolViewConfig(
              leading: const Icon(Icons.link),
              title: Text(S.of(context).urlSafe),
              trailing: Consumer(builder: (context, ref, _) {
                return Switch(
                  value: ref.watch(_urlSafe),
                  onChanged: (state) {
                    ref.read(_urlSafe.notifier).state = state;
                  },
                );
              }),
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            Consumer(builder: (context, ref, _) {
              return _Base64ImageButton(ref: ref);
            }),
            PasteButton(onPaste: (ref, data) {
              ref.read(_input).text = data;
              ref.refresh(_result);
            }),
            Consumer(builder: (context, ref, _) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  ref.read(_input).clear();
                  ref.refresh(_result);
                },
              );
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              minLines: 2,
              maxLines: 12,
              controller: ref.watch(_input),
              onChanged: (text) {
                ref.refresh(_result);
              },
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            CopyButton(onCopy: (ref) {
              return ref.read(_result);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              minLines: 2,
              maxLines: 12,
              data: ref.watch(_result),
            );
          }),
        ),
      ],
    );
  }
}
