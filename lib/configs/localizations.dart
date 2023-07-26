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
  (ref) {
    try {
      return AppLocalizations(
        LType.values.byName(ref.watch(localeProvider).languageCode.split('_').first),
      );
    } catch (_) {}

    /// 一致するenumがなければ英語
    return AppLocalizations(LType.en);
  },
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

  String get month => switch (l) {
        LType.ja => '月',
        LType.en => 'month',
      };

  String get upgradingWillUnlockTheFollowingFeatures => switch (l) {
        LType.ja => 'アップグレードで次の機能が開放されます。',
        LType.en => 'Upgrading will unlock the following features.',
      };

  String get textSearchForFacilities => switch (l) {
        LType.ja => '施設のテキスト検索',
        LType.en => 'Text search for facilities.',
      };

  String get useOfWiFiSpeedMap => switch (l) {
        LType.ja => 'Wi-Fi速度マップの利用',
        LType.en => 'Use of Wi-Fi Speed Map.',
      };

  String get earnDoublePoints => switch (l) {
        LType.ja => '獲得BAXが2倍',
        LType.en => 'earn double points.',
      };
  String get exchangePointsForRewards => switch (l) {
        LType.ja => 'BAXと特典の交換',
        LType.en => 'Exchange points for rewards.',
      };
  String get oneWeekFreeTrial => switch (l) {
        LType.ja => '１週間無料トライアル',
        LType.en => 'One week free trial',
      };
  String get billingAfterTrialEnds => switch (l) {
        LType.ja => 'トライアル終了後に課金されます。',
        LType.en => 'You will be charged after the trial ends.',
      };
  String get cancelAnytimeInSettings => switch (l) {
        LType.ja => '設定画面からいつでも中止できます。',
        LType.en => 'You can cancel anytime from the settings.',
      };
  String get restoreFailed => switch (l) {
        LType.ja => '復元に失敗しました。',
        LType.en => 'Restore failed.',
      };
  String get restorePurchase => switch (l) {
        LType.ja => '以前購入された方はこちら',
        LType.en => 'Restore purchase',
      };
  String get agreeToBelowBeforeUse => switch (l) {
        LType.ja => '下記に同意の上ご利用ください。',
        LType.en => 'Please agree to the following before use',
      };
  String get XXX => switch (l) {
        LType.ja => '下記に同意の上ご利用ください。',
        LType.en => 'XXX',
      };
}
