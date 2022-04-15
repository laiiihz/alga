import 'package:alga/constants/import_helper.dart';

class ColorViewBackgroundPainter extends CustomPainter {
  final Color lineColor;
  ColorViewBackgroundPainter(this.lineColor);
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..color = lineColor;
    const gap = 20.0;
    final double w = size.width;
    final double h = size.height;
    int horizontalGaps = w ~/ gap + 1;
    int verticalGaps = h ~/ gap + 1;
    for (var i = 1; i < horizontalGaps; i++) {
      canvas.drawLine(Offset(i * gap, 0), Offset(i * gap, h), linePaint);
    }
    for (var i = 1; i < verticalGaps; i++) {
      canvas.drawLine(Offset(0, i * gap), Offset(w, i * gap), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
