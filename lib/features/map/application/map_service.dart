import 'dart:async';

import 'package:bax/features/map/data/map_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapServiceProvider = Provider((ref) {
  return MapService(ref);
});

class MapService {
  MapService(this.ref);

  final Ref ref;

  /// 保留中の検索文字列
  String? _holdQuery;

  Future<void> searchFacilities(String query, String localeLanguage) async {
    _holdQuery = query;
    // 無駄な連続リクエストをなるべく避けるため、一定時間後のholdQueryがqueryと一致していた場合のみリクエストを送信する
    Future.delayed(const Duration(milliseconds: 600), () {
      if (_holdQuery == query) {
        // TODO: Validationチェック。
        // 無駄なリクエストを避けるため空文字や無意味な記号などが来たらリクエストしないようにする。

        /// TODO: loggerに置き換え
        print('検索Query: $query');
        return ref.watch(mapRepositoryProvider).searchFacilities(query, localeLanguage);
      }
    });
  }

  Future<void> geocoding(String facilityId) async {
    return ref.watch(mapRepositoryProvider).geocoding(facilityId);
  }
}
