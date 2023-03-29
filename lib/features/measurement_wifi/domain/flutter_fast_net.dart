import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fast_net_result.dart';

final flutterFastNetProvider = Provider((_) => FlutterFastNet());

final speedTestProvider = StreamProvider.autoDispose(
  (ref) => ref.read(flutterFastNetProvider).analyzeSpeed(),
);

class FlutterFastNet {
  static const _testServer = 'https://fast.com/#';

  HeadlessInAppWebView _createHeadlessBrowser(StreamController<FastNetResult> streamController) {
    return HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(_testServer)),
      onLoadStop: (controller, url) async {
        await _speedTest(controller, streamController);
      },
    );
  }

  Stream<FastNetResult> analyzeSpeed() {
    HeadlessInAppWebView? browser;
    final streamController = StreamController<FastNetResult>(
      onCancel: () async {
        await browser?.dispose();
      },
    );
    browser = _createHeadlessBrowser(streamController);
    unawaited(browser.run());
    return streamController.stream;
  }

  Future<void> _speedTest(
    InAppWebViewController inAppWebViewController,
    StreamController<FastNetResult> streamController,
  ) async {
    while (!streamController.isClosed) {
      final result = await _extractSpeedTestResultFromFastCom(
        inAppWebViewController,
      );

      if (result == null || result.isDone) {
        await streamController.close();
        return;
      }

      streamController.add(result);
    }
  }

  static const String _source = '''
(function(){ 
    const downloadSpeedValue= document.querySelector('#speed-value').textContent;
    const downloadSpeedUnit =document.querySelector('#speed-units').textContent;
    const uploadSpeedValue = document.querySelector('#upload-value').textContent;
    const uploadSpeedUnit = document.querySelector('#upload-units').textContent;
    const isDone= Boolean(
      document.querySelector('#speed-value.succeeded') && document.querySelector('#upload-value.succeeded')
    );

    const latencyValue = document.querySelector('#latency-value').textContent;
    const bufferbloatValue = document.querySelector('#bufferbloat-value').textContent;

    const userISP = document.querySelector('#user-isp').textContent;
    return{downloadSpeedValue, downloadSpeedUnit, uploadSpeedValue, uploadSpeedUnit, isDone, latencyValue, bufferbloatValue, userISP};
 })()''';

  Future<FastNetResult?> _extractSpeedTestResultFromFastCom(
    InAppWebViewController controller,
  ) async {
    try {
      final res = await controller.evaluateJavascript(
            source: _source,
          ) as Map? ??
          {};

      return FastNetResult.fromJson(
        Map<String, dynamic>.from(res),
      );
    } catch (_) {}
    return null;
  }
}
