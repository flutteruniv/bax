import 'package:flutter/material.dart';

class UploadPainter extends CustomPainter {
  UploadPainter({required this.color, required this.height, required this.width});
  final Color color;
  final double height;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.1, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.9, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
