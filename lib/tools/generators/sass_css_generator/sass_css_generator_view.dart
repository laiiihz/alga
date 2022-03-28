import 'package:alga/constants/import_helper.dart';
import 'package:sass/sass.dart';
part './sass_css_generator_provider.dart';

class SassCssGeneratorView extends StatefulWidget {
  const SassCssGeneratorView({Key? key}) : super(key: key);

  @override
  State<SassCssGeneratorView> createState() => _SassCssGeneratorViewState();
}

class _SassCssGeneratorViewState extends State<SassCssGeneratorView> {
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).sassCssGenerator),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              leading: const Icon(Icons.compress),
              title: Text(S.of(context).compress),
              trailing: Consumer(builder: (context, ref, _) {
                return Switch(
                  value: ref.watch(_compress),
                  onChanged: (state) {
                    ref.read(_compress.notifier).state = state;
                  },
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
              ref.refresh(_cssResult);
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return LangTextField(
              lang: LangHighlightType.scss,
              controller: ref.watch(_inputController),
              minLines: 2,
              maxLines: 12,
              onChanged: (_) {
                ref.refresh(_cssResult);
              },
            );
          }),
        ),
        AppTitleWrapper(
          title: 'CSS result',
          actions: [
            CopyButton(onCopy: (ref) => ref.read(_cssResult)),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              lang: LangHighlightType.css,
              data: ref.watch(_cssResult),
              minLines: 2,
              maxLines: 12,
            );
          }),
        ),
      ],
    );
  }
}
