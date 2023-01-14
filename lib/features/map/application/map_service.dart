import 'package:bax/features/map/data/map_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapServiceProvider = Provider.autoDispose((ref) {
  return MapService(ref);
});

class MapService {
  MapService(this.ref);

  final Ref ref;

  Future<void> searchFacilities(String word) async {
    // Todo: 連続リクエストの制御
    // １文字入力される度にリクエストするので、前のリクエストが実行中だった場合はキャンセルしたい。
    // キャンセルできない場合は前の結果が返ってきたとしても無視したい。
    // x文字目の検索結果よりも先にx+1文字目の検索結果が返ってきてしまった場合、結果が上書きされてしまうため。

    // Todo: Validationチェック。
    // 無駄なリクエストを避けるため無意味な記号などが来たらアラートを出したい。

    return ref.watch(mapRepositoryProvider).searchFacilities(word);
  }
}
