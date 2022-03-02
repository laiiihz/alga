import 'dart:math';

part 'data.dart';

class LoremIpsum {
  static final Random _random = Random();
  static late int length = _wordList.length;

  /// generate words
  static List<String> words(int count) {
    return List.generate(
      count,
      (index) => _wordList[_random.nextInt(length - 1)],
    );
  }

  static String sentence() {
    int size = 4 + _random.nextInt(20);
    return words(size).join(' ') + '.';
  }

  static List<String> sentences(int count) {
    return List.generate(count, (index) => sentence()).toList();
  }

  static String paragraph() {
    int size = 2 + _random.nextInt(10);
    return '  ' + sentences(size).join(' ');
  }

  static List<String> paragraphs(int count) {
    return List.generate(count, (index) => paragraph()).toList();
  }
}
