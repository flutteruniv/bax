import 'dart:async';

import 'package:bax/features/map/data/map_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapServiceProvider = Provider((ref) {
  return MapService(ref);
});

/// Todo: true, falseが切り替わるときだけ通知したい。
/// 入力中であるかどうかを返すProvider
final isTypingStreamProvider = StreamProvider(
  (ref) {
    return ref.watch(mapServiceProvider).isTypingStream();
  },
);

class MapService {
  MapService(this.ref);

  final Ref ref;

  final _isTypingController = StreamController<bool>();

  Stream<bool> isTypingStream() {
    return _isTypingController.stream;
  }

  Future<void> searchFacilities(String word, String localeLanguage) async {
    _isTypingController.add(word.isNotEmpty);

    // Todo: 連続リクエストの制御
    // ○秒後のwordと一致していた場合のみリクエストしたい。

    // Todo: Validationチェック。
    // 無駄なリクエストを避けるため空文字や無意味な記号などが来たらリクエストしないようにする。

    return ref.watch(mapRepositoryProvider).searchFacilities(word, localeLanguage);
  }
}
