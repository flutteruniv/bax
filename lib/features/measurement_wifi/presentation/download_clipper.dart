import 'package:flutter/material.dart';

class DownloadClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.1, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.9, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(DownloadClipper oldClipper) => true;
}
