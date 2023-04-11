import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateProvider(
  (ref) => const Locale('ja'),
);

final localizationsProvider = Provider(
  (ref) => AppLocalizations(ref.watch(localeProvider).languageCode),
);

class AppLocalizations {
  AppLocalizations(this.l);

  final String l;

  String? get terms => {
        'ja': '利用規約',
        'en': 'Terms of Use',
      }[l];

  String? get privacy => {
        'ja': 'プライバシーポリシー',
        'en': 'Privacy policy',
      }[l];

  String? get searchWiFi => {
        'ja': 'Wi-Fiスポットを探す',
        'en': 'Search for Wi-Fi hotspots',
      }[l];

  String? get downloadSpeed => {
        'ja': 'Wifiダウンロード速度',
        'en': 'Wi-Fi download speed',
      }[l];

  String? get notMeasured => {
        'ja': 'Wifiダウンロード速度',
        'en': 'Wi-Fi download speed',
      }[l];
}
