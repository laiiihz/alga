import 'package:devtoys/tools/encoders_decoders/base_64_encoder_decoder/base_64_provider.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:devtoys/widgets/tool_view.dart';
import 'package:devtoys/widgets/tool_view_config.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../encoder_decoder_type.dart';

class Base64EncoderDecoderView extends StatefulWidget {
  const Base64EncoderDecoderView({Key? key}) : super(key: key);

  @override
  State<Base64EncoderDecoderView> createState() =>
      _Base64EncoderDecoderViewState();
}

class _Base64EncoderDecoderViewState extends State<Base64EncoderDecoderView> {
  final _provider = Base64Provider();

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
      title: const Text('Base 64 Encoder/Decoder'),
      children: [
        const AppTitle(title: 'Config'),
        ToolViewConfig(
          leading: const Icon(FluentIcons.switch_widget),
          title: const Text('type'),
          trailing: Combobox(
            items: EncodeDecodeType.values
                .map((e) => ComboboxItem(
                      child: Text(e.value),
                      value: e,
                    ))
                .toList(),
            value: _provider.type,
            onChanged: (EncodeDecodeType? value) {
              _provider.type = value ?? EncodeDecodeType.encode;
            },
          ),
        ),
        AppTitleWrapper(
          title: 'input',
          actions: [
            Button(
              child: const Icon(FluentIcons.paste),
              onPressed: () {
                _provider.paste();
              },
            ),
          ],
          child: TextBox(
            minLines: 10,
            maxLines: 10,
            controller: _provider.inputController,
            onChanged: (text) {
              _provider.convert();
            },
          ),
        ),
        AppTitleWrapper(
          title: 'output',
          actions: [
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: () {
                _provider.paste();
              },
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: () {
                _provider.clearAll();
              },
            ),
          ],
          child: TextBox(
            minLines: 10,
            maxLines: 10,
            controller: _provider.outputController,
            onChanged: (text) {
              _provider.convert();
            },
          ),
        ),
      ],
    );
  }
}
