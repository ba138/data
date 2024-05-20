import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    // Draw the red triangle
    Path redTriangle = Path();
    redTriangle.moveTo(0, 0);
    redTriangle.lineTo(size.width, 0);
    redTriangle.lineTo(0, size.height);
    redTriangle.close();

    paint.color = const Color(0xff613EEA);
    canvas.drawPath(redTriangle, paint);

    // Draw the green triangle
    Path greenTriangle = Path();
    greenTriangle.moveTo(size.width, 0);
    greenTriangle.lineTo(size.width, size.height);
    greenTriangle.lineTo(0, size.height);
    greenTriangle.close();

    paint.color = const Color(0xff2B2C4E);
    canvas.drawPath(greenTriangle, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
