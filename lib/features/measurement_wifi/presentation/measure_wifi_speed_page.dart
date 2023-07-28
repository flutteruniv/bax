import 'dart:async';
import 'dart:io';

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
import 'speed_indicator.dart';
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
          final l = ref.watch(localizationsProvider);
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l.checkConnectionAndMeasure),
                ElevatedButton(
                  onPressed: () {
                    if (Platform.isIOS) {
                      const MethodChannel('openSetting').invokeMethod('openSetting');
                    } else {
                      SystemSettings.wifi();
                    }
                  },
                  child: Text(l.toWiFiSettings),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  context.go(FacilityMapPage.route);
                },
                child: Text(l.backToMap),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  startSpeedTest();
                },
                child: Text(l.measure),
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
    final l = ref.watch(localizationsProvider);

    final res = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(selectedFacility!.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l.postToThisFacility),
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
                  child: Text(l.doubleBAXWithProPlan),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(l.later),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(l.post),
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
          uid: ref.read(uidProvider) ?? '',
        );

    if (!canPostResult) {
      if (!mounted) {
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(l.onePostPerDay),
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
    final l = ref.watch(localizationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('SSID: ${ref.watch(ssidProvider).valueOrNull ?? l.notConnected}'),
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
                    child: Text(l.post),
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
                  child: Text(l.selectFacility),
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
                        ? Text(l.cancel)
                        : Text(
                            l.measureAgain,
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
