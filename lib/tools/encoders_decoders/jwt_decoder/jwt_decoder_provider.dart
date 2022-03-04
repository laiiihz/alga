import 'dart:convert';

import 'package:devtoys/constants/import_helper.dart';
import 'package:devtoys/utils/clipboard_util.dart';

class JWTDecoderProvider {
  final inputController = TextEditingController();
  final headerController = TextEditingController();
  final payloadController = TextEditingController();

  clear() {
    inputController.clear();
    headerController.clear();
    payloadController.clear();
  }

  paste() async {
    inputController.text = await ClipboardUtil.paste();
  }

  copyHeader() {
    ClipboardUtil.copy(headerController.text);
  }

  copyPayload() {
    ClipboardUtil.copy(payloadController.text);
  }

  convert() {
    final result = JWTModel.fromToken(inputController.text);
    final jEncoder = JsonEncoder.withIndent(' ' * 4);
    if (result != null) {
      headerController.text = jEncoder.convert(result.header);
      payloadController.text = jEncoder.convert(result.payload);
    }
  }

  void dispose() {
    inputController.dispose();
    headerController.dispose();
    payloadController.dispose();
  }
}

class JWTModel {
  final Map<String, dynamic> header;
  final Map<String, dynamic> payload;
  final String sign;
  JWTModel({
    required this.header,
    required this.payload,
    required this.sign,
  });

  static JWTModel? fromToken(String token) {
    const bDecoder = Base64Decoder();
    List<String> result = token.split('.');
    if (result.length != 3) return null;
    // here must has 3 string in result
    try {
      final headerRaw = base64.normalize(result[0]);
      final payloadRaw = base64.normalize(result[1]);
      final headerString = String.fromCharCodes(bDecoder.convert(headerRaw));
      final payloadString = String.fromCharCodes(bDecoder.convert(payloadRaw));
      final signString = result[2];
      const jDeocder = JsonDecoder();
      final header = jDeocder.convert(headerString);
      final payload = jDeocder.convert(payloadString);
      return JWTModel(header: header, payload: payload, sign: signString);
    } catch (e) {
      return null;
    }
  }
}
