bool versionCheck(String minimumVersion, String nowVersion) {
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
