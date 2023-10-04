import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:sass/sass.dart';

import 'package:alga/utils/constants/import_helper.dart';

part './sass_css_generator_provider.dart';

class SassCssGeneratorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SassCssGeneratorView();
  }
}

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
            AlgaConfigSwitch(
              leading: const Icon(Icons.compress),
              title: Text(S.of(context).compress),
              value: _compress,
            ),
            ToolViewMenuConfig<Syntax>(
              title: Text(context.tr.sassSourceType),
              name: (ref) => ref.watch(_syntax).toString(),
              initialValue: (WidgetRef ref) => ref.watch(_syntax),
              items: [Syntax.css, Syntax.sass, Syntax.scss]
                  .map((e) => PopupMenuItem(
                        value: e,
                        child: Text(e.toString()),
                      ))
                  .toList(),
              onSelected: (syntax, ref) {
                ref.read(_syntax.notifier).update((state) => syntax);
              },
            ),
          ],
        ),
        AppTitleWrapper(
          title: context.tr.sassSource,
          actions: [
            PasteButtonWidget(
              _inputController,
              onUpdate: (ref) => ref.refresh(_inputText),
            ),
            ClearButtonWidget(
              _inputController,
              onUpdate: (ref) => ref.refresh(_inputText),
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            return LangTextField(
              lang: LangHighlightType.scss,
              controller: ref.watch(_inputController),
              minLines: 2,
              maxLines: 12,
              onChanged: (_) => ref.refresh(_inputText),
            );
          }),
        ),
        AppTitleWrapper(
          title: context.tr.sassResult,
          actions: [
            CopyButtonWithText(_css),
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
