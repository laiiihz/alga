import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/image_tools/qrcode_tool/qrcode_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrcodeView extends StatefulWidget {
  const QrcodeView({Key? key}) : super(key: key);

  @override
  State<QrcodeView> createState() => _QrcodeViewState();
}

class _QrcodeViewState extends State<QrcodeView> {
  final _provider = QRcodeProvider();
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
      title: Text(S.of(context).qrCodeTool),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              title: Text(S.of(context).qrVersion),
              trailing: SizedBox(
                width: 120,
                child: TextField(
                  controller: _provider.versionController,
                  decoration:
                      InputDecoration(hintText: S.of(context).qrAutoVersion),
                  onChanged: (_) {
                    _provider.setQrVersion(_provider.versionController.text);
                  },
                ),
              ),
            ),
            ToolViewConfig(
              title: Text(S.of(context).errorCorrectionLevel),
              trailing: DropdownButton<int>(
                items: QrErrorCorrectLevel.levels
                    .map((e) => DropdownMenuItem(
                          child: Text(QrErrorCorrectLevel.getName(e)),
                          value: e,
                        ))
                    .toList(),
                onChanged: (item) {
                  _provider.errorCorrectionLevel =
                      item ?? QrErrorCorrectLevel.L;
                },
                value: _provider.errorCorrectionLevel,
              ),
            ),
            ToolViewConfig(
              title: Text(S.of(context).qrGapless),
              trailing: Switch(
                value: _provider.gapless,
                onChanged: (state) {
                  _provider.gapless = state;
                },
              ),
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: const [],
          child: TextField(
            controller: _provider.inputController,
            onChanged: (_) {
              setState(() {});
            },
          ),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: const [],
          child: SizedBox(
            height: 300,
            child: Center(
              child: QrImage(
                data: _provider.inputController.text,
                version: _provider.qrVersion,
                errorCorrectionLevel: _provider.errorCorrectionLevel,
                gapless: _provider.gapless,
                backgroundColor: Colors.transparent,
                foregroundColor: isDark(context) ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
