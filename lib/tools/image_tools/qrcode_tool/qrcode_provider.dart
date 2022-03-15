import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcodeProvider extends ChangeNotifier {
  final inputController = TextEditingController();
  final versionController = TextEditingController();

  int _qrVersion = QrVersions.auto;
  int get qrVersion => _qrVersion;
  setQrVersion(String version) {
    final v = int.tryParse(version);
    if (v == null) {
      _qrVersion = QrVersions.auto;
    } else {
      bool supported = QrVersions.isSupportedVersion(v);
      _qrVersion = supported ? v : QrVersions.auto;
    }

    notifyListeners();
  }

  int _errorCorrectionLevel = QrErrorCorrectLevel.L;
  int get errorCorrectionLevel => _errorCorrectionLevel;
  set errorCorrectionLevel(int level) {
    _errorCorrectionLevel = level;
    notifyListeners();
  }

  bool _gapless = true;
  bool get gapless => _gapless;
  set gapless(bool state) {
    _gapless = state;
    notifyListeners();
  }

  @override
  void dispose() {
    inputController.dispose();
    versionController.dispose();
    super.dispose();
  }
}
