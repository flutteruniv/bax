import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/application/auth_service.dart';
import '../../bax/presentation/bax_reward_dialog.dart';
import '../../map/domain/nearby_search_results/nearby_search_result.dart';
import '../../map/presentation/facility_map_page.dart';
import '../../map/presentation/nearby_search_results_dialog.dart';
import '../application/measurement_wifi_service.dart';
import '../data/measurement_wifi_repository.dart';
import '../domain/fast_net_result.dart';
import '../domain/flutter_fast_net.dart';
import '../domain/wifi_scanner.dart';
import 'wifi_result.dart';

class MeasureWiFiSpeedPage extends ConsumerStatefulWidget {
  const MeasureWiFiSpeedPage({super.key});

  static const route = 'measure_wifi';
  static const name = 'measureWifi';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeasureWiFiSpeedPageState();
}

class _MeasureWiFiSpeedPageState extends ConsumerState<MeasureWiFiSpeedPage> {
  FastNetResult? fastNetResult;
  StreamSubscription<FastNetResult>? sub;

  bool isProcessing = false;
  bool isDone = false;

  String? ssid;

  Future<void> startSpeedTest() async {
    isDone = false;
    ssid = await ref.refresh(ssidProvider.future);
    if (ssid == null) {
      if (!mounted) {
        return;
      }
      await showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            content: const Text('Wi-Fiに接続されていることを確認して、測定ボタンを押してください。'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  context.go(FacilityMapPage.route);
                },
                child: const Text('マップに戻る'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  startSpeedTest();
                },
                child: const Text('測定'),
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      isProcessing = true;
    });

    await sub?.cancel();
    sub = ref.read(flutterFastNetProvider).analyzeSpeed().listen(
      (event) {
        setState(() {
          fastNetResult = event;
        });
      },
      onDone: () {
        setState(() {
          setState(() {
            isProcessing = false;
            isDone = true;
          });
        });
      },
    );
  }

  void stopSpeedTest() {
    setState(() {
      isProcessing = false;
    });
    sub?.cancel();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startSpeedTest();
  }

  @override
  Widget build(BuildContext context) {
    // nearbySearchResults = ref.watch(myNearbyFacilityProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('SSID: ${ref.watch(ssidProvider).valueOrNull ?? '未接続'}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(48, 0),
                child: Transform.scale(
                  scale: 1.5,
                  child: SizedBox(
                    height: 240,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SpeedIndicator(
                            speed: fastNetResult?.downloadSpeedMbps ?? 0.0,
                            isDownload: true,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SpeedIndicator(
                            speed: fastNetResult?.uploadSpeedMbps ?? 0.0,
                            isDownload: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              if (isProcessing)
                const SizedBox(
                  height: 12,
                  child: Center(child: LinearProgressIndicator()),
                )
              else
                const SizedBox(height: 12),
              const SizedBox(height: 60),
              if (isDone && !isProcessing)
                SizedBox(
                  height: 40,
                  width: 240,
                  child: ElevatedButton(
                    onPressed: () async {
                      final res = await showDialog<NearbySearchResult>(
                        context: context,
                        builder: (context) {
                          return const NearbySearchResultsDialog();
                        },
                      );
                      final ssid = this.ssid;
                      final fastNetResult = this.fastNetResult;

                      if (ssid == null || fastNetResult == null || res == null) {
                        return;
                      }

                      final canPostResult = await ref.read(measurementWifiRepositoryProvider).hasTodayData(
                            placeId: res.placeId,
                            today: DateTime.now().toUtc(),
                            uid: ref.read(uidProvider).valueOrNull ?? '',
                          );

                      if (!canPostResult) {
                        if (!mounted) {
                          return;
                        }
                        await showDialog<void>(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text('同じ施設に投稿できるのは1日に1回までです。明日またご協力ください。'),
                            );
                          },
                        );
                        return;
                      }

                      final bax = await ref.read(measurementWifiServiceProvider).postMeasurementResult(
                            ssid,
                            fastNetResult,
                            res,
                          );
                      if (!mounted) {
                        return;
                      }

                      if (bax == null) {
                        return;
                      }

                      await showDialog<void>(
                        context: context,
                        builder: (context) {
                          return BaxRewordDialog(bax: bax);
                        },
                      );

                      if (!mounted) {
                        return;
                      }

                      setState(() {
                        isDone = false;
                      });

                      await showDialog<void>(
                        context: context,
                        builder: (context) {
                          return WiFiResultDialog(
                            ssid: ssid,
                            fastNetResult: fastNetResult,
                            nearbySearchResult: res,
                          );
                        },
                      );
                      if (!mounted) {
                        return;
                      }

                      Navigator.of(context).pop();
                    },
                    child: const Text('施設を選んで投稿'),
                  ),
                )
              else
                const SizedBox(height: 40),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 40,
                  width: 240,
                  child: OutlinedButton(
                    onPressed: isProcessing ? stopSpeedTest : startSpeedTest,
                    child: isProcessing
                        ? const Text('キャンセル')
                        : const Text(
                            'もう一度測定',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    return Stack(
      children: [
        CustomPaint(
          painter: isDownload
              ? DownloadPainter(
                  color: Colors.black,
                  width: 320,
                  height: 160,
                )
              : UploadPainter(
                  color: Colors.black,
                  width: 320,
                  height: 160,
                ),
          child: const SizedBox(
            width: 320,
            height: 160,
          ),
        ),
        ClipPath(
          clipper: isDownload ? DownloadClipper() : UploadClipper(),
          child: Container(
            width: 320,
            height: 160,
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 160,
              width: speed * 2.5,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 160,
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
            angle: isDownload ? pi / 6 : -pi / 6,
            child: SizedBox(
              height: 24,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  isDownload ? 'Download: $speed Mbps' : 'Upload: $speed Mbps',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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

class DownloadPainter extends CustomPainter {
  DownloadPainter({required this.color, required this.height, required this.width});
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
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.1, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.9, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
