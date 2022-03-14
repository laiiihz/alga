import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/sass_css_generator/sass_css_generator_provider.dart';

class SassCssGeneratorView extends StatefulWidget {
  const SassCssGeneratorView({Key? key}) : super(key: key);

  @override
  State<SassCssGeneratorView> createState() => _SassCssGeneratorViewState();
}

class _SassCssGeneratorViewState extends State<SassCssGeneratorView> {
  final _provider = SassCssGeneratorProvider();
  update() => setState(() {});
  @override
  void initState() {
    super.initState();
    _provider.addListener(update);
  }

  @override
  void dispose() {
    _provider.removeListener(update);
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('SCSS/CSS generator'),
      children: [
        AppTitle(title: S.of(context).configuration),
        ToolViewConfig(
          leading: const Icon(Icons.compress),
          title: Text(S.of(context).compress),
          trailing: Switch.adaptive(
            value: _provider.compressResult,
            onChanged: (state) {
              _provider.compressResult = state;
              _provider.generate();
            },
          ),
        ),
        AppTitleWrapper(
          title: 'SCSS source',
          actions: [
            IconButton(
              onPressed: () {
                _provider.paste();
                _provider.generate();
              },
              icon: const Icon(Icons.paste),
            ),
          ],
          child: LangTextField(
            lang: LangHighlightType.scss,
            controller: _provider.scssController,
            minLines: 2,
            maxLines: 12,
            onChanged: (_) {
              _provider.generate();
            },
          ),
        ),
        AppTitleWrapper(
          title: 'CSS result',
          actions: [
            IconButton(
              onPressed: () {
                _provider.copy();
              },
              icon: const Icon(Icons.copy),
            ),
          ],
          child: AppTextBox(
            lang: LangHighlightType.css,
            data: _provider.cssResult,
            minLines: 2,
            maxLines: 12,
          ),
        ),
      ],
    );
  }
}
