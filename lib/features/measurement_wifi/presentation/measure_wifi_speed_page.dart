import 'dart:async';

import 'package:bax/features/measurement_wifi/domain/fast_net_result.dart';
import 'package:bax/features/measurement_wifi/domain/flutter_fast_net.dart';
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
  FastNetResult? fastNetResult;

  StreamSubscription<FastNetResult>? sub;

  bool isProcessing = false;

  Future<void> startSpeedTest() async {
    ref.invalidate(ssidProvider);

    final ssid = await ref.read(ssidProvider.future);
    if (ssid == null) {
      // TODO(kenta-wakasa): WiFiとの接続状況を確認してください。
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
