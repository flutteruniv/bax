import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../configs/localizations.dart';

/// 強制アップデート促すダイアログ
class UpdateDialog extends ConsumerWidget {
  const UpdateDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(localizationsProvider);
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.4),
        ),
        SimpleDialog(
          children: [
            SimpleDialogOption(
              child: Text(l.pleaseUpdate),
            ),
            SimpleDialogOption(
              child: ElevatedButton(
                onPressed: _launchUrl,
                child: Text(l.update),
              ),
            )
          ],
        ),
      ],
    );
  }

  // TODO(kenta-wakasa): ストア情報が未確定のため仮でおいてる。正式に決まったら差し替える。
  Future<void> _launchUrl() async {
    final appStoreURL = Uri.parse('https://apps.apple.com/us/app/bax/id1663757722');
    final playStoreURL = Uri.parse('https://play.google.com/store/apps/details?id=com.flutteruniv.bax');

    if (Platform.isAndroid) {
      if (!await launchUrl(playStoreURL)) {
        throw Exception('Could not launch $playStoreURL');
      }
    } else {
      if (!await launchUrl(appStoreURL)) {
        throw Exception('Could not launch $appStoreURL');
      }
    }
  }

  // TODO(kenta-wakasa):
  /// 強制アップデートが必要かどうかを提供するproviderを用意してもいいかもしれない。
  static bool versionCheck(String minimumVersion, String nowVersion) {
    // minimum と now をスプリットする
    final minimumVersionArray = minimumVersion.split('.');
    final nowVersionArray = nowVersion.split('.');

    // minimumより小さかったら true を返す
    for (var i = 0; i < minimumVersionArray.length; i++) {
      final minimum = int.parse(minimumVersionArray[i]);
      final now = int.parse(nowVersionArray[i]);

      if (minimum > now) {
        return true;
      }
    }
    return false;
  }
}
