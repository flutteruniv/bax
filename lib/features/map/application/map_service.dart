import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../location/domain/my_location.dart';
import '../data/map_repository.dart';

final mapServiceProvider = Provider((ref) {
  return MapService(ref);
});

/// 自分の現在位置の近くの施設を検索して結果を返す[FutureProvider]
final myNearbyFacilityProvider = FutureProvider.autoDispose(
  (ref) async {
    final position = await ref.read(initLocationProvider.future);
    if (position == null) {
      return null;
    }
    return ref.watch(mapRepositoryProvider).fetchNearByFacility(
          GeoPoint(
            position.latitude,
            position.longitude,
          ),
        );
  },
  dependencies: [
    initLocationProvider,
    mapRepositoryProvider,
  ],
);

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
}
