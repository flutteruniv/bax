import 'package:flutter/material.dart';

class UploadClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.1, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.9, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(UploadClipper oldClipper) => true;
}
