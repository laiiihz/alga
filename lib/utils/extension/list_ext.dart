import 'dart:math' as math;

extension ListExt<T> on List<T> {
  List<T> sep(T seperate) {
    return List.generate(math.max(0, length * 2 - 1), (index) {
      final currentIndex = index ~/ 2;
      if (index.isEven) {
        return this[currentIndex];
      } else {
        return seperate;
      }
    });
  }
}
