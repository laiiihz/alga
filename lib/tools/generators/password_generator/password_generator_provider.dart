part of './password_generator_view.dart';

const _uppercaseBox = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const _lowercaseBox = 'abcdefghijklmnopqrstuvwxyz';
const _numberBox = '0123456789';
const _symbolBox = r'!@#$%^&*';
final _lengthCtr = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});
final _useLength = StateProvider.autoDispose<int>((ref) {
  final length = ref.watch(_lengthCtr).text;
  return int.tryParse(length) ?? 8;
});

final _useUppercase = StateProvider.autoDispose<bool>((ref) => true);
final _useLowercase = StateProvider.autoDispose<bool>((ref) => true);
final _useNumbers = StateProvider.autoDispose<bool>((ref) => true);
final _useSymbols = StateProvider.autoDispose<bool>((ref) => true);

final _passBox = StateProvider.autoDispose<List<String>>((ref) {
  final useUppercase = ref.watch(_useUppercase);
  final useLowercase = ref.watch(_useLowercase);
  final useNumbers = ref.watch(_useNumbers);
  final useSymbols = ref.watch(_useSymbols);
  final resultBox = <String>[];
  if (useUppercase) resultBox.addAll(_uppercaseBox.characters);
  if (useLowercase) resultBox.addAll(_lowercaseBox.characters);
  if (useNumbers) resultBox.addAll(_numberBox.characters);
  if (useSymbols) resultBox.addAll(_symbolBox.characters);
  return resultBox;
});

final _result = StateProvider.autoDispose<String>((ref) {
  final length = ref.watch(_useLength);
  final passBox = ref.watch(_passBox);
  final boxLength = passBox.length;
  final random = Random();
  final buffer = StringBuffer();
  for (var i = 0; i < length; i++) {
    buffer.write(passBox[random.nextInt(boxLength)]);
  }
  return buffer.toString();
});
