// ignore_for_file: public_member_api_docs, sort_constructors_first
class JWT {
  JWT({
    required this.header,
    required this.payload,
    required this.sign,
  });

  factory JWT.fromMap(
      Map<String, dynamic> p0, Map<String, dynamic> p1, String p2) {
    return JWT(
      header: JWTHeader.fromMap(p0),
      payload: JWTPayload(data: p1),
      sign: p2,
    );
  }
  final JWTHeader header;
  final JWTPayload payload;
  final String sign;

  @override
  String toString() => 'JWT(header: $header, payload: $payload)';
}

class JWTHeader {
  const JWTHeader({
    required this.algorithm,
    required this.type,
  });

  factory JWTHeader.fromMap(Map<String, dynamic> map) {
    return JWTHeader(algorithm: map['alg'] ?? '', type: map['typ'] ?? '');
  }

  final String algorithm;
  final String type;

  @override
  String toString() => 'JWTHeader(algorithm: $algorithm, type: $type)';
}

class JWTPayload {
  JWTPayload({
    required this.data,
  });

  final Map<String, dynamic> data;

  String? get issuer => this['iss'];
  DateTime? get expirationTime => _time(this['exp']);
  DateTime? get notBefore => _time(this['nbf']);
  DateTime? get issuedAt => _time(this['iat']);
  int? get jwtId => int.tryParse(this['jti']);
  String? get subject => this['sub'];
  String? get audience => this['aud'];

  DateTime? _time(String? value) {
    if (value == null) return null;
    return DateTime.tryParse('${value}000');
  }

  dynamic operator [](String key) => data[key];

  @override
  String toString() => 'JWTPayload(data: $data)';
}
