import 'package:alga_parser/jwt_parser.dart';

final _jwt =
    r'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9l5p2lIiwiaWF0IjoxNTE2MjM5MDIyfQ.shcaJS90hnD5QPutpTwoP48-ML3bPIUXkW8d4Tnxme0';
void main() {
  final data = parseJWT(_jwt);
  print(data);
}
