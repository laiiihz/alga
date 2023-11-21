part of 'jwt_decoder.dart';

@riverpod
(JWTModel?, String?) results(ResultsRef ref) {
  final a = stringConfigProvider(const Key('content'));
  final content = ref.watch(a);
  if (content.isEmpty) return (null, null);
  try {
    return (JWTModel.fromToken(content), null);
  } catch (e) {
    return (null, e.toString());
  }
}

class JWTModel {
  JWTModel({
    required this.header,
    required this.payload,
    required this.sign,
  });
  final Map<String, dynamic> header;
  final Map<String, dynamic> payload;
  final String sign;

  String get headerJson => const JsonEncoder.withIndent('  ').convert(header);
  String get payloadJson => const JsonEncoder.withIndent('  ').convert(payload);

  static JWTModel fromToken(String token) {
    const bDecoder = Base64Decoder();
    List<String> result = token.split('.');
    if (result.length != 3) {
      throw Exception('token must has 3 string in result');
    }
    final headerRaw = base64.normalize(result[0]);
    final payloadRaw = base64.normalize(result[1]);
    final headerString = String.fromCharCodes(bDecoder.convert(headerRaw));
    final payloadString = String.fromCharCodes(bDecoder.convert(payloadRaw));
    final signString = result[2];
    const jDeocder = JsonDecoder();
    final header = jDeocder.convert(headerString);
    final payload = jDeocder.convert(payloadString);
    return JWTModel(header: header, payload: payload, sign: signString);
  }
}
