import 'package:py_dict_parser/py_dict_parser.dart';

void main() {
  final parser = PyDictParserDefinition().build();
  final result = parser.parse('''
{'a': 1, "b": 2,'c':(1,2,3)}
''').value;
  print(result);
}
