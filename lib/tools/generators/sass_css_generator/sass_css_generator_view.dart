import 'package:sass/sass.dart';

import 'package:alga/constants/import_helper.dart';

part './sass_css_generator_provider.dart';

class SassCssGeneratorView extends StatefulWidget {
  const SassCssGeneratorView({super.key});

  @override
  State<SassCssGeneratorView> createState() => _SassCssGeneratorViewState();
}

class _SassCssGeneratorViewState extends State<SassCssGeneratorView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).sassCssGenerator),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewSwitchConfig(
              leading: const Icon(Icons.compress),
              title: Text(S.of(context).compress),
              value: (ref) => ref.watch(_compress),
              onChanged: (state, ref) =>
                  ref.read(_compress.notifier).state = state,
            ),
            ToolViewConfig(
              title: const Text('Source Type'),
              trailing: Consumer(builder: (context, ref, _) {
                return DropdownButton<Syntax>(
                  items: [Syntax.css, Syntax.sass, Syntax.scss]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  onChanged: (syntax) {
                    ref.read(_syntax.notifier).state = syntax ?? Syntax.scss;
                  },
                  value: ref.watch(_syntax),
                );
              }),
            ),
          ],
        ),
        AppTitleWrapper(
          title: 'SCSS source',
          actions: [
            PasteButton(onPaste: (ref, data) {
              ref.watch(_inputController).text = data;
              return ref.refresh(_cssResult);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return LangTextField(
              lang: LangHighlightType.scss,
              controller: ref.watch(_inputController),
              minLines: 2,
              maxLines: 12,
              onChanged: (_) {
                return ref.refresh(_cssResult);
              },
            );
          }),
        ),
        AppTitleWrapper(
          title: 'CSS result',
          actions: [
            CopyButton(onCopy: (ref) => ref.read(_css)),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(
              lang: LangHighlightType.css,
              text: ref.watch(_css),
              minLines: 2,
              maxLines: 12,
            );
          }),
        ),
      ],
    );
  }
}
