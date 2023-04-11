import 'dart:convert';

import 'package:alga_parser/src/jwt/jwt.dart';
import 'package:petitparser/definition.dart';
import 'package:petitparser/parser.dart';

class JWTDefinition extends GrammarDefinition<JWT> {
  @override
  Parser<JWT> start() =>
      seq5(contentMap(), char('.'), contentMap(), char('.'), content())
          .map5((header, _, payload, __, sign) {
        return JWT.fromMap(header, payload, sign);
      });

  Parser<String> content() => pattern('0-9A-Za-z_-').starString();
  Parser<Map<String, dynamic>> contentMap() =>
      content().map((value) => _base64Map(value));

  Map<String, dynamic> _base64Map(String data) {
    final raw = base64.decode(base64.normalize(data));
    final obj = utf8.decode(raw);
    return json.decode(obj);
  }
}
