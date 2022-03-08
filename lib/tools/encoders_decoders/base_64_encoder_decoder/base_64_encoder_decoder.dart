import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/base_64_encoder_decoder/base_64_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
      title: Text(S.of(context).encoderDecoderBase64),
      children: [
        AppTitle(title: S.of(context).configuration),
        ToolViewConfig(
          leading: const Icon(FluentIcons.switch_widget),
          title: Text(S.of(context).conversion),
          subtitle: Text(S.of(context).selectConversion),
          trailing: Row(
            children: [
              _provider.isEncode
                  ? Text(S.of(context).encode)
                  : Text(S.of(context).decode),
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
          title: S.of(context).input,
          actions: [
            Button(
              child: const Icon(FluentIcons.paste),
              onPressed: () {
                _provider.paste();
              },
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: () {
                _provider.clear();
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
          title: S.of(context).output,
          actions: [
            Button(
              child: const Icon(Icons.copy),
              onPressed: () {
                _provider.paste();
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
