import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/fast_net_result.dart';
import '../domain/wifi_measurement_result.dart';

class WiFiResultDialog extends StatelessWidget {
  const WiFiResultDialog({super.key, required this.fastNetResult});

  final FastNetResult fastNetResult;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final globalKey = GlobalKey();

    Future<XFile?> widgetToImage() async {
      Uint8List? bytes;
      final boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        return null;
      }
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      bytes = byteData?.buffer.asUint8List();
      if (bytes == null) {
        return null;
      }
      // pathをうまく設定できず...
      // final file = File.fromRawPath(bytes);
      // final newPath = '${file.path}/widget_image.png';
      // print(newPath);
      // File newFile = await file.renameSync(newPath);
      // return XFile(newFile.path);
      return XFile.fromData(
        bytes,
        name: 'wifi-result-image.png',
        mimeType: 'image/png',
      );
    }

    return Stack(
      children: [
        // 背景の地図部分
        Align(
          child: Container(
            alignment: Alignment.bottomCenter,
            width: size.width * 0.8,
            height: size.height * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/map.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.share),
                onPressed: () {},
                label: const Text('結果をシェア'),
              ),
            ),
          ),
        ),
        const AlertDialog(
          elevation: 0,
        ),
        // 吹き出し
        Positioned(
          top: size.height * 0.1,
          left: size.width * 0.2,
          right: size.width * 0.2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/balloon.png'),
              Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        '東京スカイツリー東京スカイツリー東京スカイツリー東京スカイツリー',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12,),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          fastNetResult.downloadSpeedMbps.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Mbps',
                          style: TextStyle(fontSize: 16, height: 3),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Image.asset(
                            'assets/images/star.png',
                            width: 32,
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // ピン
        Align(
          child: SvgPicture.asset(
            'assets/images/push-pin02.svg',
            height: 70,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
