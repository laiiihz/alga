import 'package:devtoys/tools/encoders_decoders/encoder_decoder_type.dart';
import 'package:flutter/material.dart';

class UriProvider extends ChangeNotifier {
  final inputController = TextEditingController();
  final outputController = TextEditingController();

  EncodeDecodeType _type = EncodeDecodeType.encode;
  EncodeDecodeType get type => _type;
  set type(EncodeDecodeType state) {
    _type = state;
    notifyListeners();
  }

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }
}
