import 'dart:math';

import 'package:alga/tools/generators/password_generator/password_gen.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_gen.provider.g.dart';

final _uppercaseBox = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.characters.toList();
final _lowercaseBox = 'abcdefghijklmnopqrstuvwxyz'.characters.toList();
final _numberBox = '0123456789'.characters.toList();
final _symbolBox = r'!@#$%^&*'.characters.toList();
final _rnd = Random.secure();

@riverpod
String results(ResultsRef ref) {
  final uppercase = ref.watch(useUppercase);
  final lowercase = ref.watch(useLowercase);
  final numbers = ref.watch(useDigit);
  final special = ref.watch(useSpecial);
  final count = ref.watch(useCount);
  final resultBox = <String>[];
  final randomBox = <String>[];
  if (uppercase) {
    resultBox.add(_uppercaseBox.takeRandom());
    randomBox.addAll(_uppercaseBox);
  }
  if (lowercase) {
    resultBox.add(_lowercaseBox.takeRandom());
    randomBox.addAll(_lowercaseBox);
  }
  if (numbers) {
    resultBox.add(_numberBox.takeRandom());
    randomBox.addAll(_numberBox);
  }
  if (special) {
    resultBox.add(_symbolBox.takeRandom());
    randomBox.addAll(_symbolBox);
  }

  for (var i = 0; i < count - resultBox.length; i++) {
    resultBox.add(randomBox.takeRandom());
  }

  resultBox.shuffle(_rnd);
  return resultBox.join();
}

extension on List<String> {
  String takeRandom() {
    final index = _rnd.nextInt(length);
    return elementAt(index);
  }
}
