import 'dart:convert';

import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';

class JWTDecoderProvider extends ChangeNotifier {
  final inputController = TextEditingController();

  String _headerResult = '';
  String get headerResult => _headerResult;
  set headerResult(String state) {
    _headerResult = state;
    notifyListeners();
  }

  String _payloadResult = '';
  String get payloadResult => _payloadResult;
  set payloadResult(String state) {
    _payloadResult = state;
    notifyListeners();
  }

  clear() {
    inputController.clear();
    headerResult = '';
    payloadResult = '';
  }

  paste() async {
    inputController.text = await ClipboardUtil.paste();
  }

  copyHeader() {
    ClipboardUtil.copy(headerResult);
  }

  copyPayload() {
    ClipboardUtil.copy(payloadResult);
  }

  convert() {
    final result = JWTModel.fromToken(inputController.text);
    final jEncoder = JsonEncoder.withIndent(' ' * 4);
    if (result != null) {
      headerResult = jEncoder.convert(result.header);
      payloadResult = jEncoder.convert(result.payload);
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
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
