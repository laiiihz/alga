import 'dart:convert';

import 'package:alga/constants/import_helper.dart';

part './uri_parser_provider.dart';

class UriParserView extends StatefulWidget {
  const UriParserView({Key? key}) : super(key: key);

  @override
  State<UriParserView> createState() => _UriParserViewState();
}

class _UriParserViewState extends State<UriParserView> {
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).uriParser),
      children: [
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            RefReadonly(builder: (ref) {
              return IconButton(
                onPressed: () async {
                  ref.watch(_input).text = await ClipboardUtil.paste();
                  ref.refresh(_uri);
                },
                icon: const Icon(Icons.paste),
              );
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return LangTextField(
              lang: LangHighlightType.uri,
              controller: ref.watch(_input),
              onChanged: (_) {
                ref.refresh(_uri);
              },
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
                        IconButton(
                          onPressed: () {
                            ClipboardUtil.copy(e.name);
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                      child: AppTextBox(
                        data: e.name,
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
