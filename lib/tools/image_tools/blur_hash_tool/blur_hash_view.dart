import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/image_tools/blur_hash_tool/blur_hash_provider.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class BlurHashView extends StatefulWidget {
  const BlurHashView({Key? key}) : super(key: key);

  @override
  State<BlurHashView> createState() => _BlurHashViewState();
}

class _BlurHashViewState extends State<BlurHashView> {
  final _provider = BlurHashProvider();
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
      title: const Text('Blur Hash Tool'),
      children: [
        ToolViewWrapper(children: [
          ToolViewConfig(
            leading: const Icon(Icons.image),
            title: const Text('Pick image'),
            trailing: TextButton(
              onPressed: () async {
                await _provider.gen();
              },
              child: const Text('Pick'),
            ),
          ),
        ]),
        SizedBox(
          height: 140,
          child: Row(
            children: [
              Expanded(
                child: _provider.imageItem == null
                    ? const SizedBox.shrink()
                    : AppTitleWrapper(
                        title: 'Raw Image',
                        actions: const [],
                        child: Expanded(
                          child: Image.file(
                            _provider.imageItem!.file,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: _provider.imageItem == null
                    ? const SizedBox.shrink()
                    : AppTitleWrapper(
                        title: 'Blurhash Image',
                        actions: const [],
                        child: Expanded(
                          child: BlurHash(
                            hash: _provider.imageItem!.blurHash.hash,
                            imageFit: BoxFit.contain,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        if (_provider.imageItem != null)
          AppTitleWrapper(
            title: 'blurhash',
            actions: const [],
            child: AppTextBox(data: _provider.imageItem!.blurHash.hash),
          ),
      ],
    );
  }
}
