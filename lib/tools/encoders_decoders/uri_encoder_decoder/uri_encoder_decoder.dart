import 'package:devtoys/tools/encoders_decoders/uri_encoder_decoder/uri_provider.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:devtoys/widgets/tool_view.dart';
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
        AppTitleWrapper(
          title: 'input',
          actions: [],
          child: TextBox(
            maxLines: 12,
            minLines: 12,
            controller: _provider.inputController,
          ),
        ),
        AppTitleWrapper(
          title: 'output',
          actions: [],
          child: TextBox(
            maxLines: 12,
            minLines: 12,
            controller: _provider.inputController,
          ),
        ),
      ],
    );
  }
}
