import 'package:bax/features/measurement_wifi/domain/wifi_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeasureWiFiSpeedPage extends ConsumerStatefulWidget {
  const MeasureWiFiSpeedPage({super.key});

  static const route = 'measure_wifi';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeasureWiFiSpeedPageState();
}

class _MeasureWiFiSpeedPageState extends ConsumerState<MeasureWiFiSpeedPage> {
  @override
  Widget build(BuildContext context) {
    final wifiScannerAsyncValue = ref.watch(wifiScannerProvider);
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

            Expanded(
              child: wifiScannerAsyncValue.when(
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
                          final res = await data.measureInternetSpeed();
                          print(res.ssid);
                          print(res.downloadSpeedMbps);
                          print(res.uploadSpeedMbps);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
