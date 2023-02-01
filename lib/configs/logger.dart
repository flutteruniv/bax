import 'dart:io';

import 'package:roggle/roggle.dart';

const _loggerName = '[BAX]';

final logger = Roggle(
  printer: SinglePrettyPrinter(
    loggerName: _loggerName,
    // error 以上のときはスタックトレースを出力する
    stackTraceLevel: Level.error,
    stackTracePrefix: '>>>',
    // iOS はカラー非対応
    colors: !Platform.isIOS,
    // ログが長くなるので非表示
    printCaller: false,
  ),
);
