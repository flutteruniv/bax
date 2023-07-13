import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateProvider(
  (ref) {
    final defaultLocaleName = Platform.localeName;
    return Locale(defaultLocaleName);
  },
);

final localizationsProvider = Provider(
  (ref) => AppLocalizations(LType.values.byName(ref.watch(localeProvider).languageCode.split('_').first)),
);

enum LType { en, ja }

class AppLocalizations {
  AppLocalizations(this.l);

  final LType l;

  String get terms => switch (l) {
        LType.ja => '利用規約',
        LType.en => 'Terms of Use',
      };

  String get privacy => switch (l) {
        LType.ja => 'プライバシーポリシー',
        LType.en => 'Privacy policy',
      };

  String get searchWiFi => switch (l) {
        LType.ja => 'Wi-Fiスポットを探す',
        LType.en => 'Search for Wi-Fi hotspots',
      };
  String get downloadSpeed => switch (l) {
        LType.ja => 'ダウンロード速度',
        LType.en => 'download speed',
      };

  String get notMeasured => switch (l) {
        LType.ja => '未測定',
        LType.en => 'Not measured',
      };
  String get searchHear => switch (l) {
        LType.ja => 'ここで検索',
        LType.en => 'Search here',
      };
}
