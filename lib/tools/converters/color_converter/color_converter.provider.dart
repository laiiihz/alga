part of 'color_converter.dart';

class ColorResult {
  ColorResult(this.color);

  final Color color;

  String get cssHex {
    final buf = StringBuffer();
    buf.write('#');
    buf.write(color.red.pad2hex);
    buf.write(color.green.pad2hex);
    buf.write(color.blue.pad2hex);
    if (color.opacity != 1) {
      buf.write(color.alpha.pad2hex);
    }
    return buf.toString();
  }

  String get flutterHex =>
      '0x${color.value.toRadixString(16).toUpperCase().padLeft(8, '0')}';

  String get cssRGB {
    final buf = StringBuffer();
    if (color.opacity == 1) {
      buf.write('rgb(');
    } else {
      buf.write('rgba(');
    }

    buf.write(color.red);
    buf.write(', ');
    buf.write(color.green);
    buf.write(', ');
    buf.write(color.blue);
    if (color.opacity != 1) {
      buf.write(', ');
      buf.write(color.opacity.toStringAsFixed(2));
    }
    buf.write(')');

    return buf.toString();
  }

  HSLColor get hsl => HSLColor.fromColor(color);

  String get cssHSL {
    final buf = StringBuffer();
    final hsl = HSLColor.fromColor(color);
    if (color.opacity == 1) {
      buf.write('hsl(');
    } else {
      buf.write('hsla(');
    }

    buf.write(hsl.hue.toStringAsFixed(3));
    buf.write(', ');
    buf.write(hsl.saturation.toStringAsFixed(2));
    buf.write(', ');
    buf.write(hsl.lightness.toStringAsFixed(2));
    if (color.opacity != 1) {
      buf.write(', ');
      buf.write(color.opacity.toStringAsFixed(2));
    }
    buf.write(')');

    return buf.toString();
  }

  HSVColor get hsv => HSVColor.fromColor(color);
}

@riverpod
(ColorResult?, String?) result(ResultRef ref) {
  final content = ref.watch(_useContent);
  if (content.isEmpty) {
    return (null, null);
  }
  Color? next;
  if (content.startsWith('0x') && content.length == 10) {
    next = _parseFlutterColor(content);
  }
  if (next != null) {
    return (ColorResult(next), null);
  }
  try {
    return (ColorResult(Pigment.fromString(content)), null);
  } catch (e) {
    return (null, e.toString());
  }
}

Color? _parseFlutterColor(String content) {
  final value = int.tryParse(content.substring(2), radix: 16);
  if (value == null) return null;
  return Color(value);
}

extension on int {
  String get pad2hex {
    return toRadixString(16).padLeft(2, '0');
  }
}
