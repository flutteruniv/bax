import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:system_settings/system_settings.dart';

import '../../../configs/localizations.dart';
import '../../authentication/application/auth_service.dart';
import '../../bax/presentation/bax_reward_dialog.dart';
import '../../map/domain/nearby_search_results/nearby_search_result.dart';
import '../../map/presentation/facility_map_page.dart';
import '../../map/presentation/nearby_search_results_dialog.dart';
import '../../payment/presentation/payment_dialog.dart';
import '../../payment/repository/payment_repository.dart';
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

  /// 選択された施設
  NearbySearchResult? selectedFacility;

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
          final localizations = ref.watch(localizationsProvider);
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Wi-Fiに接続されていることを確認して、測定ボタンを押してください。'),
                ElevatedButton(
                  onPressed: () {
                    if (Platform.isIOS) {
                      const MethodChannel('openSetting').invokeMethod('openSetting');
                    } else {
                      SystemSettings.wifi();
                    }
                  },
                  child: const Text('Wi-Fi設定画面へ'),
                ),
              ],
            ),
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
      onDone: () async {
        setState(() {
          setState(() {
            isProcessing = false;
            isDone = true;
          });
        });

        if (selectedFacility == null) {
          return;
        }

        if (!mounted) {
          return;
        }

        await postWiFiMeasurementResult();
      },
    );
  }

  Future<void> postWiFiMeasurementResult() async {
    final ssid = this.ssid;
    final fastNetResult = this.fastNetResult;
    final selectedFacility = this.selectedFacility;

    final res = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(selectedFacility!.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('この施設に投稿しますか？'),
              const SizedBox(height: 8),
              if (!ref.watch(isProProvider))
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        fullscreenDialog: true,
                        builder: (context) {
                          return const PaymentDialog();
                        },
                      ),
                    );
                  },
                  child: const Text('Proプランで獲得BAX2倍'),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('あとで'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('投稿'),
            ),
          ],
        );
      },
    );

    if (res != true) {
      return;
    }

    if (ssid == null || fastNetResult == null || selectedFacility == null) {
      return;
    }

    final canPostResult = await ref.read(measurementWifiRepositoryProvider).hasTodayData(
          placeId: selectedFacility.placeId,
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
          selectedFacility,
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

    await showDialog<void>(
      context: context,
      builder: (context) {
        return WiFiResultDialog(
          ssid: ssid,
          fastNetResult: fastNetResult,
          nearbySearchResult: selectedFacility,
        );
      },
    );
    setState(() {
      isDone = false;
      this.selectedFacility = null;
    });

    if (!mounted) {
      return;
    }

    final inAppReview = InAppReview.instance;

    /// サポート対象端末であるかのチェック
    if (await inAppReview.isAvailable()) {
      /// アプリ内レビューをリクエスト
      await inAppReview.requestReview();
    }
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
                offset: Offset(MediaQuery.of(context).size.width * 0.1, 0),
                child: Transform.scale(
                  scale: 1.5,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
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
              const SizedBox(height: 80),
              if (isProcessing)
                const SizedBox(
                  height: 12,
                  child: Center(child: LinearProgressIndicator()),
                )
              else
                const SizedBox(height: 12),
              Text(
                selectedFacility?.name ?? '',
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              if (selectedFacility != null && isDone)
                SizedBox(
                  height: 40,
                  width: 240,
                  child: ElevatedButton(
                    onPressed: postWiFiMeasurementResult,
                    child: const Text('投稿'),
                  ),
                ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                width: 240,
                child: OutlinedButton(
                  onPressed: () async {
                    final res = await showDialog<NearbySearchResult>(
                      context: context,
                      builder: (context) {
                        return const NearbySearchResultsDialog();
                      },
                    );
                    if (res == null) {
                      return;
                    }
                    selectedFacility = res;
                    setState(() {});
                  },
                  child: const Text('施設を選ぶ'),
                ),
              ),
              const SizedBox(height: 16),
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
