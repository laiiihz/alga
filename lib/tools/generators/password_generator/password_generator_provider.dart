part of './password_generator_view.dart';

final _uppercaseBox = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.characters.toList();
final _lowercaseBox = 'abcdefghijklmnopqrstuvwxyz'.characters.toList();
final _numberBox = '0123456789'.characters.toList();
final _symbolBox = r'!@#$%^&*'.characters.toList();
final _lengthCtr = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});
final _useLength = StateProvider.autoDispose<int>((ref) {
  final length = ref.watch(_lengthCtr).text;
  int actualLength = int.tryParse(length) ?? 8;
  if (actualLength < 8) actualLength = 8;
  return actualLength;
});

final _useUppercase = StateProvider.autoDispose<bool>((ref) => true);
final _useLowercase = StateProvider.autoDispose<bool>((ref) => true);
final _useNumbers = StateProvider.autoDispose<bool>((ref) => true);
final _useSymbols = StateProvider.autoDispose<bool>((ref) => true);

final _basicBox = Provider.autoDispose<List<String>>((ref) {
  final useUppercase = ref.watch(_useUppercase);
  final useLowercase = ref.watch(_useLowercase);
  final useNumbers = ref.watch(_useNumbers);
  final useSymbols = ref.watch(_useSymbols);
  final result = <String>[];
  if (useUppercase) {
    _uppercaseBox.shuffle();
    result.addAll(_uppercaseBox.take(2));
  }
  if (useLowercase) {
    _lowercaseBox.shuffle();
    result.addAll(_lowercaseBox.take(2));
  }
  if (useNumbers) {
    _numberBox.shuffle();
    result.addAll(_numberBox.take(2));
  }
  if (useSymbols) {
    _symbolBox.shuffle();
    result.addAll(_symbolBox.take(2));
  }
  return result;
});

final _result = Provider.autoDispose<String>((ref) {
  final length = ref.watch(_useLength) - 8;

  final resultBox = <String>[];
  final useUppercase = ref.watch(_useUppercase);
  final useLowercase = ref.watch(_useLowercase);
  final useNumbers = ref.watch(_useNumbers);
  final useSymbols = ref.watch(_useSymbols);
  final baseResult = ref.watch(_basicBox);
  if (useUppercase) resultBox.addAll(_uppercaseBox);
  if (useLowercase) resultBox.addAll(_lowercaseBox);
  if (useNumbers) resultBox.addAll(_numberBox);
  if (useSymbols) resultBox.addAll(_symbolBox);

  final results = <String>[...baseResult];
  final r = Random();
  for (var i = 0; i < length; i++) {
    results.add(resultBox[r.nextInt(resultBox.length)]);
  }
  results.shuffle();
  return results.join();
});
