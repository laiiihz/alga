import 'dart:convert';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:language_textfield/language_highlight_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jwt_decoder.g.dart';
part 'jwt_decoder.provider.dart';

final _useContent = stringConfigProvider(const Key('content'));

class JwtDecoderRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const JwtDecoderPage();
  }
}

class JwtDecoderPage extends ConsumerStatefulWidget {
  const JwtDecoderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JwtDecoderPageState();
}

class _JwtDecoderPageState extends ConsumerState<JwtDecoderPage> {
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref.read(_useContent.notifier).change(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(resultsProvider);
    return ScrollableScaffold(
      title: Text(context.tr.decoderJWT),
      children: [
        AlgaToolbar(
          actions: [
            PasteButton(controller: _controller),
            ClearButton(controller: _controller),
          ],
        ),
        TextField(
          controller: _controller,
          minLines: 3,
          maxLines: 12,
        ),
        CrossFade(
          state: result.$1 != null,
          first: Column(
            children: <Widget>[
              AlgaToolbar(title: Text(context.tr.jwtHeader)),
              AppTextField(
                text: result.$1?.headerJson,
                language: HighlightType.json,
              ),
              AlgaToolbar(title: Text(context.tr.jwtPayload)),
              AppTextField(
                text: result.$1?.payloadJson,
                language: HighlightType.json,
              ),
            ].sep(const SizedBox(height: 8)),
          ),
        ),
      ],
    );
  }
}
