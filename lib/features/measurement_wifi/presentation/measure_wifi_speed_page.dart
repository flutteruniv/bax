import 'package:bax/features/load/application/loading_notifier.dart';
import 'package:bax/features/measurement_wifi/domain/wifi_measurement_result.dart';
import 'package:bax/features/measurement_wifi/domain/wifi_scanner.dart';
import 'package:bax/features/measurement_wifi/presentation/wifi_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeasureWiFiSpeedPage extends ConsumerStatefulWidget {
  const MeasureWiFiSpeedPage({super.key});

  static const route = 'measure_wifi';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeasureWiFiSpeedPageState();
}

class _MeasureWiFiSpeedPageState extends ConsumerState<MeasureWiFiSpeedPage> {
  WifiMeasurementResult? wifiMeasurementResult;

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

            /// ここの値
            Row(
              children: [
                Text(
                  'Flutter別荘',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                OutlinedButton(
                  // TODO(kenta-wakasa): 半径10m以内の10件の施設を出す
                  onPressed: () {},
                  child: const Text('選び直す'),
                ),
              ],
            ),
            if (wifiMeasurementResult != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SSID: ${wifiMeasurementResult!.ssid}'),
                  Text('ダウンロード速度: ${wifiMeasurementResult!.downloadSpeedMbps.toStringAsFixed(2)} Mbps'),
                  Text('アップロード速度: ${wifiMeasurementResult!.uploadSpeedMbps.toStringAsFixed(2)} Mbps'),
                ],
              ),
            Expanded(
              child: WiFiMeasureButton(
                onComplete: (wifiMeasurementResult) async {
                  this.wifiMeasurementResult = wifiMeasurementResult;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WiFiMeasureButton extends ConsumerWidget {
  const WiFiMeasureButton({
    super.key,
    required this.onComplete,
  });

  final void Function(WifiMeasurementResult) onComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(wifiScannerProvider).when(
      loading: () {
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      },
      error: (e, s) {
        return ElevatedButton(
          onPressed: () {},
          child: const Text('接続を見直す'),
        );
      },
      data: (data) {
        return Container(
          alignment: Alignment.center,
          child: SizedBox.square(
            dimension: 120,
            child: ElevatedButton(
              onPressed: () async {
                ref.read(loadingProvider.notifier).show();
                final wifiMeasurementResult = await data.measureInternetSpeed();
                ref.read(loadingProvider.notifier).hide();
                onComplete(wifiMeasurementResult);
                showDialog(
                    context: context,
                    builder: (context) {
                      return WiFiResultDialog(wifiMeasurementResult: wifiMeasurementResult);
                    });
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
        );
      },
    );
  }
}
