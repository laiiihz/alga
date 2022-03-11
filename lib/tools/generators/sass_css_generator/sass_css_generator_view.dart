import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/sass_css_generator/sass_css_generator_provider.dart';
import 'package:language_textfield/language_textfield.dart';

class SassCssGeneratorView extends StatefulWidget {
  const SassCssGeneratorView({Key? key}) : super(key: key);

  @override
  State<SassCssGeneratorView> createState() => _SassCssGeneratorViewState();
}

class _SassCssGeneratorViewState extends State<SassCssGeneratorView> {
  final _provider = SassCssGeneratorProvider();
  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('SCSS/CSS generator'),
      children: [
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
            inputDecoration:
                const InputDecoration(border: OutlineInputBorder()),
            onChanged: (_) {
              _provider.generate();
            },
          ),
        ),
        AppTitleWrapper(
          title: 'CSS result',
          actions: [],
          child: LangTextField(
            lang: LangHighlightType.css,
            controller: _provider.cssController,
            minLines: 2,
            maxLines: 12,
            inputDecoration:
                const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
