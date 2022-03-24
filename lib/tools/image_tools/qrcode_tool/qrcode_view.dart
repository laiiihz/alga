import 'package:alga/constants/import_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';

part './qrcode_provider.dart';

class QrcodeView extends StatefulWidget {
  const QrcodeView({Key? key}) : super(key: key);

  @override
  State<QrcodeView> createState() => _QrcodeViewState();
}

class _QrcodeViewState extends State<QrcodeView> {
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
                child: Consumer(builder: (context, ref, _) {
                  return TextField(
                    controller: ref.watch(_versionInput),
                    decoration:
                        InputDecoration(hintText: S.of(context).qrAutoVersion),
                    onChanged: (text) {
                      ref.refresh(_version);
                    },
                  );
                }),
              ),
            ),
            ToolViewConfig(
              title: Text(S.of(context).errorCorrectionLevel),
              trailing: Consumer(builder: (context, ref, _) {
                return DropdownButton<int>(
                  items: QrErrorCorrectLevel.levels
                      .map((e) => DropdownMenuItem(
                            child: Text(QrErrorCorrectLevel.getName(e)),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (item) {
                    ref.read(_errorCorrectionLevel.notifier).state =
                        item ?? QrErrorCorrectLevel.L;
                  },
                  value: ref.watch(_errorCorrectionLevel),
                );
              }),
            ),
            ToolViewConfig(
              title: Text(S.of(context).qrGapless),
              trailing: Consumer(builder: (context, ref, _) {
                return Switch(
                  value: ref.watch(_gapless),
                  onChanged: (state) {
                    ref.read(_gapless.notifier).state = state;
                  },
                );
              }),
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: const [],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_input),
              onChanged: (_) {
                ref.refresh(_inputData);
              },
              minLines: 1,
              maxLines: 12,
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: const [],
          child: SizedBox(
            height: 300,
            child: Center(
              child: Consumer(builder: (context, ref, _) {
                return QrImage(
                  data: ref.watch(_inputData),
                  version: ref.watch(_version),
                  errorCorrectionLevel: ref.watch(_errorCorrectionLevel),
                  gapless: ref.watch(_gapless),
                  backgroundColor: Colors.transparent,
                  foregroundColor:
                      isDark(context) ? Colors.white : Colors.black,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
