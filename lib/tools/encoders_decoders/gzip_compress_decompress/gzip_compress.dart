import 'dart:convert';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GZipCompressRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GZipCompressPage();
  }
}

class GZipCompressPage extends StatefulWidget {
  const GZipCompressPage({super.key});

  @override
  State<GZipCompressPage> createState() => _GZipCompressPageState();
}

class _GZipCompressPageState extends State<GZipCompressPage> {
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
        title: Text(context.tr.encoderDecoderGzip),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AlgaToolbar(
              title: Text(context.tr.original),
              actions: [
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
    final g = GZipEncoder();
    const b = Base64Encoder();
    try {
      final results = g.encode(utf8.encode(text));
      if (results == null) throw Exception('Empty Data');
      _encodedInput.text = b.convert(results);
      _originalError = null;
    } catch (e) {
      _originalError = e.toString();
    }
    _safe();
  }

  void _decode(String text) {
    final g = GZipDecoder();
    const b = Base64Decoder();
    try {
      final results = g.decodeBytes(b.convert(text));
      _originalInput.text = utf8.decode(results);
      _encodedError = null;
    } catch (e) {
      _encodedError = e.toString();
    }
  }

  void _safe() {
    if (mounted) setState(() {});
  }
}
