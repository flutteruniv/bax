import 'dart:async';

import 'package:bax/features/map/data/map_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapServiceProvider = Provider((ref) {
  return MapService(ref);
});

class MapService {
  MapService(this.ref);

  final Ref ref;

  Future<void> searchFacilities(String word, String localeLanguage) async {
    // TODO: 連続リクエストの制御
    // ○秒後のwordと一致していた場合のみリクエストしたい。

    // TODO: Validationチェック。
    // 無駄なリクエストを避けるため空文字や無意味な記号などが来たらリクエストしないようにする。

    return ref.watch(mapRepositoryProvider).searchFacilities(word, localeLanguage);
  }
}
