import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/user/application/user_service.dart';

final localeProvider = Provider(
  (ref) {
    final defaultLocaleName = Platform.localeName;
    return Locale(defaultLocaleName);
  },
);

final localizationsProvider = Provider(
  (ref) {
    try {
      final languageCode = ref.watch(loginUserProvider).valueOrNull?.data()?.languageCode;
      return AppLocalizations(
        languageCode ?? LType.values.byName(ref.watch(localeProvider).languageCode.split('_').first),
      );
    } catch (_) {}

    /// 一致するenumがなければ英語
    return AppLocalizations(LType.en);
  },
);

enum LType {
  en('English'),
  ja('日本語');

  const LType(this.displayName);

  final String displayName;
}

class AppLocalizations {
  AppLocalizations(this.l);

  final LType l;

  String get terms => switch (l) {
        LType.ja => '利用規約',
        LType.en => 'Terms of use',
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
        LType.en => 'Earn double points.',
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
  String get myPage => switch (l) {
        LType.ja => 'マイページ',
        LType.en => 'My Page',
      };
  String get confirmLogout => switch (l) {
        LType.ja => 'ログアウトしますか？\nメールアドレス未連携の場合、BAXはすべて失われます。',
        LType.en => 'Are you sure you want to log out? \nIf your email address is not linked, all BAX will be lost.',
      };
  String get cancel => switch (l) {
        LType.ja => 'キャンセル',
        LType.en => 'Cancel',
      };
  String get ok => switch (l) {
        LType.ja => 'する',
        LType.en => 'OK',
      };
  String get linkEmailAddress => switch (l) {
        LType.ja => 'メールアドレスを連携',
        LType.en => 'Link email address',
      };
  String get use500BAX => switch (l) {
        LType.ja => '500 BAX を使う',
        LType.en => 'Use 500 BAX',
      };
  String get exchange500BAXForAmazonGift => switch (l) {
        LType.ja => '500BAXをAmazonギフト券に交換できます。事前にメールアドレスの連携が必要です。',
        LType.en => 'You can exchange 500 BAX for an Amazon gift card. You need to link your email address in advance.',
      };
  String get later => switch (l) {
        LType.ja => 'あとで',
        LType.en => 'Later',
      };
  String get exchange => switch (l) {
        LType.ja => '交換する',
        LType.en => 'Exchange',
      };
  String get exchangeCompleted => switch (l) {
        LType.ja => '正常に完了しました。3営業日以内に連携済みのメールアドレスへギフトコードが送られます。しばらくお待ち下さい。',
        LType.en =>
          'The exchange has been completed successfully. A gift code will be sent to the linked email address within 3 business days. Please wait for a while.',
      };
  String get pleaseUpdate => switch (l) {
        LType.ja => '最新バージョンにアップデートしてください。',
        LType.en => 'Please update to the latest version.',
      };
  String get update => switch (l) {
        LType.ja => 'アップデート',
        LType.en => 'Update',
      };
  String get shareResults => switch (l) {
        LType.ja => '結果を共有',
        LType.en => 'Share results',
      };
  String get checkConnectionAndMeasure => switch (l) {
        LType.ja => 'Wi-Fiに接続されていることを確認して、測定ボタンを押してください。',
        LType.en => 'Please ensure you\'re connected to Wi-Fi and then press the measure button.',
      };
  String get toWiFiSettings => switch (l) {
        LType.ja => 'Wi-Fi設定画面へ',
        LType.en => 'Go to Wi-Fi settings',
      };
  String get backToMap => switch (l) {
        LType.ja => 'マップに戻る',
        LType.en => 'Back to map',
      };
  String get measure => switch (l) {
        LType.ja => '測定',
        LType.en => 'Measure',
      };
  String get postToThisFacility => switch (l) {
        LType.ja => 'この施設に投稿しますか？',
        LType.en => 'Do you want to post to this facility?',
      };
  String get doubleBAXWithProPlan => switch (l) {
        LType.ja => 'Proプランで獲得BAX2倍',
        LType.en => 'Earn double BAX with Pro Plan',
      };
  String get post => switch (l) {
        LType.ja => '投稿',
        LType.en => 'Post',
      };
  String get onePostPerDay => switch (l) {
        LType.ja => '同じ施設に投稿できるのは1日に1回までです。明日またご協力ください。',
        LType.en => 'You can only post once per day to the same facility. Please contribute again tomorrow.',
      };
  String get notConnected => switch (l) {
        LType.ja => '未接続',
        LType.en => 'Not connected',
      };
  String get selectFacility => switch (l) {
        LType.ja => '施設を選ぶ',
        LType.en => 'Select a facility',
      };

  String get measureAgain => switch (l) {
        LType.ja => 'もう一度測定',
        LType.en => 'Measure again',
      };
  String get selectNearbyFacility => switch (l) {
        LType.ja => '近くの施設を選択',
        LType.en => 'Select nearby facility',
      };
  String get viewableWithProPlan => switch (l) {
        LType.ja => 'Proプランで閲覧可能',
        LType.en => 'Viewable with Pro Plan',
      };
  String get viewDetails => switch (l) {
        LType.ja => '詳細を見る',
        LType.en => 'View details',
      };
  String get noMatchingResults => switch (l) {
        LType.ja => '一致する検索結果がありません',
        LType.en => 'No matching results found',
      };
  String get errorOccurred => switch (l) {
        LType.ja => 'エラーが発生しました。\n時間を置いて再度お試しください。',
        LType.en => 'An error has occurred.\nPlease try again later.',
      };
  String get error => switch (l) {
        LType.ja => 'エラー',
        LType.en => 'error',
      };

  String get history => switch (l) {
        LType.ja => '履歴',
        LType.en => 'History',
      };
  String get acquired => switch (l) {
        LType.ja => '獲得',
        LType.en => 'Acquired',
      };
  String get dateOfUse => switch (l) {
        LType.ja => '利用日',
        LType.en => 'Date of use',
      };
  String get unknown => switch (l) {
        LType.ja => '不明',
        LType.en => 'Unknown',
      };
  String get loggedIn => switch (l) {
        LType.ja => 'ログインしました',
        LType.en => 'Logged in',
      };
  String get invalidEmail => switch (l) {
        LType.ja => 'メールアドレスが無効です',
        LType.en => 'Invalid email address',
      };
  String get emailSendFailed => switch (l) {
        LType.ja => 'メールの送信に失敗しました',
        LType.en => 'Failed to send email',
      };
  String get emailVerified => switch (l) {
        LType.ja => 'メールアドレスの認証が完了しました',
        LType.en => 'Email verification completed',
      };
  String get emailAlreadyVerified => switch (l) {
        LType.ja => 'このメールアドレスは既に認証済です',
        LType.en => 'This email address is already verified',
      };
  String get emailAlreadyInUse => switch (l) {
        LType.ja => 'このメールアドレスは既に他のアカウントで使用されています',
        LType.en => 'This email address is already in use by another account',
      };
  String get emailVerificationFailed => switch (l) {
        LType.ja => 'メールアドレスの認証に失敗しました',
        LType.en => 'Email verification failed',
      };
  String get enterEmail => switch (l) {
        LType.ja => 'メールアドレスを入力してください',
        LType.en => 'Please enter your email address',
      };
  String get invalidEmailFormat => switch (l) {
        LType.ja => 'メールアドレスが無効な形式です',
        LType.en => 'Invalid email format',
      };
  String get emailSentForVerification => switch (l) {
        LType.ja => 'メールアドレス受信確認用のメールを送信しました。',
        LType.en => 'We have sent an email for confirmation of receipt to your email address',
      };
  String get verifyEmail => switch (l) {
        LType.ja => 'メールをご確認いただき、メールに記載されたURLをクリックして、メール認証を完了してください。',
        LType.en =>
          'Please check your email and click on the URL provided in the email to complete the email verification.',
      };
  String get ifEmailNotReceived => switch (l) {
        LType.ja => 'メールが届かない場合、以下をご確認ください。',
        LType.en => 'If you do not receive the email, please check the following:',
      };

  String get checkSpamFolder => switch (l) {
        LType.ja => '迷惑メールフォルダに入っていませんか？',
        LType.en => 'Is it in your spam folder?',
      };
  String get setMailReception => switch (l) {
        LType.ja => 'noreply@bax.network」からのメールを受け取れるように設定してください。',
        LType.en => 'Please set your account to receive emails from "noreply@bax.network"',
      };
  String get checkEmailAddress => switch (l) {
        LType.ja => '入力したメールアドレスに誤りはありませんか？',
        LType.en => 'Is there any mistake in the email address you entered?',
      };
  String get verifyForConfirmation => switch (l) {
        LType.ja => '本人確認のため、メールアドレスの連携をお願いします',
        LType.en => 'For identity verification, please link your email address',
      };

  String get link => switch (l) {
        LType.ja => '連携',
        LType.en => 'link',
      };
  String get authenticate => switch (l) {
        LType.ja => '認証',
        LType.en => 'Authenticate',
      };
  String get resetEmail => switch (l) {
        LType.ja => 'メールアドレスを再設定',
        LType.en => 'Reset Email Address',
      };
  String get appDescription => switch (l) {
        LType.ja => 'BAXはWi-Fiの速度をみんなで測定して、Wi-Fiの速度が速い施設を探しやすくするためのアプリです。',
        LType.en =>
          'BAX is an app that enables everyone to measure Wi-Fi speeds, making it easier to find facilities with fast Wi-Fi.',
      };
  String get earnBAXDescription => switch (l) {
        LType.ja => 'Wi-Fiを測定するとBAXというポイントが付与されます。BAXはAmazonギフト券などの特典に交換可能です。',
        LType.en =>
          'You earn points called BAX when you measure Wi-Fi. BAX can be exchanged for rewards such as Amazon gift cards.',
      };
  String get measureContribution => switch (l) {
        LType.ja => 'あなたの測定が、みんなの役に立ちます。ご協力よろしくお願いいたします。',
        LType.en => 'Your measurements help everyone. Thank you for your cooperation.',
      };
  String get agreeToTerms => switch (l) {
        LType.ja => '規約に同意してはじめる',
        LType.en => 'Agree to the terms to begin',
      };
  String get transferData => switch (l) {
        LType.ja => 'データを引き継ぐ',
        LType.en => 'Transfer data',
      };
  String get xxx => switch (l) {
        LType.ja => 'データを引き継ぐ',
        LType.en => 'XXX',
      };
}
