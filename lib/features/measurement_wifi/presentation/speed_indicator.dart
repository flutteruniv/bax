import 'dart:ui';

import 'package:flutter/material.dart';

import 'download_clipper.dart';
import 'download_painter.dart';
import 'upload_clipper.dart';
import 'upload_painter.dart';

class SpeedIndicator extends StatelessWidget {
  const SpeedIndicator({
    super.key,
    required this.speed,
    required this.isDownload,
  });

  final double speed;
  final bool isDownload;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width / 2;
    return Stack(
      children: [
        CustomPaint(
          painter: isDownload
              ? DownloadPainter(
                  color: Colors.black,
                  width: width,
                  height: height,
                )
              : UploadPainter(
                  color: Colors.black,
                  width: width,
                  height: height,
                ),
          child: SizedBox(
            width: width,
            height: height,
          ),
        ),
        ClipPath(
          clipper: isDownload ? DownloadClipper() : UploadClipper(),
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.bottomLeft,
            child: Container(
              height: height,
              width: speed * (width / 200),
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: height,
          padding: isDownload
              ? const EdgeInsets.only(
                  left: 32,
                  top: 24,
                )
              : const EdgeInsets.only(
                  left: 24,
                  bottom: 16,
                ),
          alignment: isDownload ? Alignment.topLeft : Alignment.bottomLeft,
          child: Transform.rotate(
            angle: isDownload ? 0.55 : -0.55,
            child: SizedBox(
              height: 20,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  isDownload ? 'Download: $speed Mbps' : 'Upload: $speed Mbps',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
