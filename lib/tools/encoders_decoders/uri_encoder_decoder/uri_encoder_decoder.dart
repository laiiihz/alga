import 'package:devtoys/tools/encoders_decoders/uri_encoder_decoder/uri_provider.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:devtoys/widgets/tool_view.dart';
import 'package:devtoys/widgets/tool_view_config.dart';
import 'package:fluent_ui/fluent_ui.dart';

class UriEncoderDecoderView extends StatefulWidget {
  const UriEncoderDecoderView({Key? key}) : super(key: key);

  @override
  State<UriEncoderDecoderView> createState() => _UriEncoderDecoderViewState();
}

class _UriEncoderDecoderViewState extends State<UriEncoderDecoderView> {
  final _provider = UriProvider();
  update() {
    setState(() {});
  }

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
      title: const Text('Uri Encoder/Decoder'),
      children: [
        const AppTitle(title: 'Config'),
        ToolViewConfig(
          leading: const Icon(FluentIcons.switch_widget),
          title: const Text('Conversion'),
          subtitle: const Text('Select whitch conversion mode you want to use'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _provider.isEncode ? const Text('Encode') : const Text('Decode'),
              ToggleSwitch(
                checked: _provider.isEncode,
                onChanged: (state) {
                  _provider.isEncode = state;
                },
              ),
            ],
          ),
        ),
        AppTitleWrapper(
          title: 'input',
          actions: [
            Button(
              child: const Icon(FluentIcons.paste),
              onPressed: () => _provider.paste(),
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: () => _provider.clear(),
            ),
          ],
          child: TextBox(
            maxLines: 12,
            minLines: 12,
            controller: _provider.inputController,
            onChanged: (_) {
              _provider.convert();
            },
          ),
        ),
        AppTitleWrapper(
          title: 'output',
          actions: [
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: () => _provider.copy(),
            ),
          ],
          child: TextBox(
            maxLines: 12,
            minLines: 12,
            controller: _provider.outputController,
          ),
        ),
      ],
    );
  }
}
