part of './jwt_decoder_view.dart';

final _jwtInput = Provider.autoDispose<RichTextController>((ref) {
  final controller = RichTextController(builder: LanguageBuilder.jwt);
  ref.onDispose(controller.dispose);
  return controller;
});

final _jwtInputText = Provider.autoDispose((ref) => ref.watch(_jwtInput).text);

final _jwtModel = StateProvider.autoDispose<JWTModel?>((ref) {
  final text = ref.watch(_jwtInputText);
  if (text.isEmpty) return null;
  return JWTModel.fromToken(text);
});

final _headerResult = Provider.autoDispose<String>((ref) {
  final model = ref.watch(_jwtModel);
  if (model == null) return '';
  return JsonEncoder.withIndent(' ' * 4).convert(model.header);
});

final _payloadResult = Provider.autoDispose<String>((ref) {
  final model = ref.watch(_jwtModel);
  if (model == null) return '';
  return JsonEncoder.withIndent(' ' * 4).convert(model.payload);
});

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
