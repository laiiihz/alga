import 'package:py_dict_parser/py_dict_parser.dart';

void main() {
  final decoder = PyDictDecoder();
  final encoder = PyDictEncoder();
  final result = decoder.decode('''
{'string':'string','num':1.1,'bool':true,'null':null,'list':[1,2,3],'tuple':(1,2,3),'object':{'a':1,'b':2}}
''');

  print(encoder.encode(result));
}
