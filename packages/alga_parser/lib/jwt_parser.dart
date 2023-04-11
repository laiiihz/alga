import 'package:alga_parser/src/jwt/jwt.dart';
import 'package:alga_parser/src/jwt/jwt_definition.dart';

final jwt = JWTDefinition().build();

JWT parseJWT(String value) => jwt.parse(value).value;
