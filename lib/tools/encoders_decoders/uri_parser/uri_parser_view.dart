import 'dart:convert';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';

part './uri_parser_provider.dart';

class UriParserRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UriParserView();
  }
}

class UriParserView extends StatefulWidget {
  const UriParserView({super.key});

  @override
  State<UriParserView> createState() => _UriParserViewState();
}

class _UriParserViewState extends State<UriParserView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).uriParser),
      children: [
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            PasteButtonWidget(
              _input,
              onUpdate: (ref) => ref.refresh(_uri),
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            return LangTextField(
              lang: LangHighlightType.uri,
              controller: ref.watch(_input),
              onChanged: (_) => ref.refresh(_uri),
            );
          }),
        ),
        Consumer(builder: (context, ref, _) {
          return Column(
            children: ref
                .watch(_uriParts)
                .map((e) => AppTitleWrapper(
                      title: e.title(context),
                      actions: [
                        CopyButtonWithText.raw(e.name),
                      ],
                      child: AppTextField(
                        text: e.name,
                        lang: e.lang,
                      ),
                    ))
                .toList(),
          );
        }),
      ],
    );
  }
}
