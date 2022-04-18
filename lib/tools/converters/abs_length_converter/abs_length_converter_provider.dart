part of './abs_length_converter_view.dart';

enum LengthType {
  /// centimeters
  cm,

  /// millimeters
  mm,

  /// quarter-millimeters
  q,

  /// inches
  inch,

  /// picas
  pc,

  /// points
  pt,
}

extension LengthTypeExt on LengthType {
  double getInch(double value) => _getBaseline(this, value);
  double fromInch(double value) => _fromBaseLine(this, value);
  String getName(BuildContext context) {
    switch (this) {
      case LengthType.cm:
        return 'cm(centimeters)';
      case LengthType.mm:
        return 'mm(millimeters)';
      case LengthType.q:
        return 'q(quarter-millimeters)';
      case LengthType.inch:
        return 'inch(inches)';
      case LengthType.pc:
        return 'pc(picas)';
      case LengthType.pt:
        return 'pt(points)';
    }
  }
}

extension _DoubleExt on double {
  String safeFixed(int fixed) {
    String value = toStringAsFixed(fixed);
    while (value.endsWith('0')) {
      value = value.substring(0, value.length - 1);
    }

    if (value.endsWith('.')) {
      value = value.substring(0, value.length - 1);
    }

    return value;
  }
}

double _fromBaseLine(LengthType type, double baseline) {
  switch (type) {
    case LengthType.cm:
      return baseline * 2.54;
    case LengthType.mm:
      return baseline * 25.4;
    case LengthType.q:
      return baseline * 25.4 / 4;
    case LengthType.inch:
      return baseline;
    case LengthType.pc:
      return baseline * 6;
    case LengthType.pt:
      return baseline * 72;
  }
}

double _getBaseline(LengthType type, double value) {
  switch (type) {
    case LengthType.cm:
      return value / 2.54;
    case LengthType.mm:
      return value / 25.4;
    case LengthType.q:
      return value / 25.4 / 4;
    case LengthType.inch:
      return value;
    case LengthType.pc:
      return value / 6;
    case LengthType.pt:
      return value / 72;
  }
}

final _types = StateProvider.autoDispose
    .family<TextEditingController, LengthType>((ref, type) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

List<LengthType> _restOfTypes(LengthType type) {
  return [...LengthType.values]..remove(type);
}
