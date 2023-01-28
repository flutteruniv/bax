import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../map/application/map_service.dart';
import '../../map/domain/nearby_search_results/nearby_search_result.dart';
import '../../map/domain/nearby_search_results/nearby_search_results.dart';
import '../application/measurement_wifi_service.dart';
import '../domain/fast_net_result.dart';
import '../domain/flutter_fast_net.dart';
import '../domain/wifi_scanner.dart';
import 'nearby_search_results_dialog.dart';
import 'wifi_result.dart';

class MeasureWiFiSpeedPage extends ConsumerStatefulWidget {
  const MeasureWiFiSpeedPage({super.key});

  static const route = 'measure_wifi';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeasureWiFiSpeedPageState();
}

class _MeasureWiFiSpeedPageState extends ConsumerState<MeasureWiFiSpeedPage> {
  FastNetResult? fastNetResult;

  StreamSubscription<FastNetResult>? sub;

  NearbySearchResults? nearbySearchResults;
  NearbySearchResult? nearbySearchResult;

  bool isProcessing = false;

  Future<void> fetchNearByFacility() async {
    nearbySearchResults = await ref.read(myNearbyFacilityProvider.future);
    nearbySearchResult = nearbySearchResults!.results.first;
    setState(() {});
  }

  Future<void> selectFacility() async {
    final nearbySearchResults = this.nearbySearchResults;
    if (nearbySearchResults == null) {
      return;
    }
    final res = await showDialog<NearbySearchResult>(
      context: context,
      builder: (context) {
        return NearbySearchResultsDialog(nearbySearchResults: nearbySearchResults);
      },
    );
    if (res == null) {
      return;
    }
    nearbySearchResult = res;
    setState(() {});
  }

  Future<void> startSpeedTest() async {
    ref.invalidate(ssidProvider);

    final ssid = await ref.read(ssidProvider.future);
    if (ssid == null) {
      // TODO(kenta-wakasa): WiFiとの接続状況を確認してください。のエラーダイアログを出す。
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
          });
        });
        final fastNetResult = this.fastNetResult;
        final nearbySearchResult = this.nearbySearchResult;
        if (fastNetResult == null || nearbySearchResult == null) {
          return;
        }

        ref.read(measurementWifiServiceProvider).postMeasurementResult(
              nearbySearchResult.placeId,
              nearbySearchResult.name,
              fastNetResult.downloadSpeedMbps,
              fastNetResult.uploadSpeedMbps,
            );

        showDialog<void>(
          context: context,
          builder: (context) {
            return WiFiResultDialog(fastNetResult: fastNetResult);
          },
        );
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
  void initState() {
    super.initState();
    fetchNearByFacility();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              '施設名',
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    nearbySearchResult?.name ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                OutlinedButton(
                  onPressed: selectFacility,
                  child: const Text('選び直す'),
                ),
              ],
            ),
            if (fastNetResult != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SSID: ${ref.watch(ssidProvider).valueOrNull ?? ''}'),
                  Text('ダウンロード速度: ${fastNetResult!.downloadSpeedMbps} Mbps'),
                  Text('アップロード速度: ${fastNetResult!.uploadSpeedMbps} Mbps'),
                ],
              ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: SizedBox.square(
                  dimension: 120,
                  child: isProcessing
                      ? Column(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: stopSpeedTest,
                              child: const Text('キャンセル'),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await startSpeedTest();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '計測',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'スタート',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
