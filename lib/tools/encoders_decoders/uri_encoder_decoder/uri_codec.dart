import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum UriCodecType {
  full,
  component,
  query,
  ;

  String encode(String text) {
    return switch (this) {
      full => Uri.encodeFull(text),
      component => Uri.encodeComponent(text),
      query => Uri.encodeQueryComponent(text),
    };
  }

  String decode(String text) {
    return switch (this) {
      full => Uri.decodeFull(text),
      component => Uri.decodeComponent(text),
      query => Uri.decodeQueryComponent(text),
    };
  }

  String getName(BuildContext context) {
    return switch (this) {
      full => context.tr.uriTypeFull,
      component => context.tr.uriTypeComponent,
      query => context.tr.uriTypeQueryComponent,
    };
  }
}

class UriCodecRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UriCodecPage();
  }
}

class UriCodecPage extends ConsumerStatefulWidget {
  const UriCodecPage({super.key});

  @override
  ConsumerState<UriCodecPage> createState() => _UriCodecPageState();
}

class _UriCodecPageState extends ConsumerState<UriCodecPage> {
  final _originalInput = TextEditingController();
  final _encodedInput = TextEditingController();
  String? _originalError;
  String? _encodedError;

  UriCodecType _type = UriCodecType.full;
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
            ConfigMenu<UriCodecType>(
              items: UriCodecType.values,
              getName: (t) => t.getName(context),
              title: Text(context.tr.uriType),
              initItem: _type,
              onSelect: (t) {
                _type = t;
                setState(() {});
              },
            ),
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
    try {
      _encodedInput.text = _type.encode(text);
      _originalError = null;
    } catch (e) {
      _originalError = e.toString();
    }
    _safe();
  }

  void _decode(String text) {
    try {
      _originalInput.text = _type.decode(text);
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
