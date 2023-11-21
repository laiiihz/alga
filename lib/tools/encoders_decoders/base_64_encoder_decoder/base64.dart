import 'dart:convert';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'base64_file_picker.dart';

final useUrlSafe = booleanConfigProvider(const Key('urlSafe'));

class Base64CodecRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Base64CodecPage();
  }
}

class Base64CodecPage extends ConsumerStatefulWidget {
  const Base64CodecPage({super.key});

  @override
  ConsumerState<Base64CodecPage> createState() => _Base64CodecPageState();
}

class _Base64CodecPageState extends ConsumerState<Base64CodecPage> {
  final _originalInput = TextEditingController();
  final _encodedInput = TextEditingController();
  String? _originalError;
  String? _encodedError;
  @override
  void dispose() {
    _originalInput.dispose();
    _encodedInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.encoderDecoderBase64),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ConfigSwitch(
              title: Text(context.tr.urlSafe),
              value: useUrlSafe,
            ),
            AlgaToolbar(
              title: Text(context.tr.original),
              actions: [
                const Base64ImageButton(),
                PasteButton(
                  controller: _originalInput,
                  onChanged: (t) {
                    _originalInput.text = t;
                    _encode(t);
                  },
                ),
                CopyButton(() => _originalInput.text),
                ClearButton(controller: _originalInput),
              ],
            ),
            Expanded(
              child: TextField(
                expands: true,
                maxLines: null,
                controller: _originalInput,
                onChanged: _encode,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(errorText: _originalError),
              ),
            ),
            AlgaToolbar(
              title: Text(context.tr.encoded),
              actions: [
                PasteButton(
                  controller: _originalInput,
                  onChanged: (t) {
                    _encodedInput.text = t;
                    _decode(t);
                  },
                ),
                CopyButton(() => _encodedInput.text),
                ClearButton(controller: _encodedInput),
              ],
            ),
            Expanded(
              child: TextField(
                expands: true,
                maxLines: null,
                controller: _encodedInput,
                onChanged: _decode,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(errorText: _encodedError),
              ),
            ),
          ].sep(const SizedBox(height: 4)),
        ),
      ),
    );
  }

  void _encode(String text) {
    Base64Codec codec = ref.read(useUrlSafe)
        ? const Base64Codec.urlSafe()
        : const Base64Codec();
    try {
      _encodedInput.text = codec.encode(utf8.encode(text));
      _originalError = null;
    } catch (e) {
      _originalError = e.toString();
    }
    _safe();
  }

  void _decode(String text) {
    Base64Codec codec = ref.read(useUrlSafe)
        ? const Base64Codec.urlSafe()
        : const Base64Codec();
    try {
      _originalInput.text = utf8.decode(codec.decode(text));
      _encodedError = null;
    } catch (e) {
      _encodedError = e.toString();
    }
    _safe();
  }

  void _safe() {
    if (mounted) setState(() {});
  }
}
