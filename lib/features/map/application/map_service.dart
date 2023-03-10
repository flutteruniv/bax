import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../configs/logger.dart';
import '../../facility/data/facility_repository.dart';
import '../../location/domain/my_location.dart';
import '../data/map_repository.dart';
import '../domain/nearby_search_results/nearby_search_results.dart';
import '../domain/selected_location_info.dart';

/// ユーザーが施設予測結果から選択したときにロケーション情報が返される[StreamProvider]
final selectedLocationInfoStreamProvider = StreamProvider(
  (ref) {
    return ref.watch(mapServiceProvider).selectedLocationInfoStream();
  },
);

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
    final res = await ref.watch(mapRepositoryProvider).fetchNearByFacility(
          GeoPoint(
            position.latitude,
            position.longitude,
          ),
        );
    return NearbySearchResults(results: res.results.where((element) => !element.types.contains('locality')).toList());
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

  final _selectedLocationInfoController = StreamController<SelectedLocationInfo>();

  Stream<SelectedLocationInfo> selectedLocationInfoStream() {
    return _selectedLocationInfoController.stream;
  }

  Future<void> searchFacilities(String query, String localeLanguage) async {
    _holdQuery = query;
    // 無駄な連続リクエストをなるべく避けるため、一定時間後のholdQueryがqueryと一致していた場合のみリクエストを送信する
    Future.delayed(const Duration(milliseconds: 600), () {
      if (_holdQuery == query) {
        // TODO: Validationチェック。
        /// 無駄なリクエストを避けるため空文字や無意味な記号などが来たらリクエストしないようにする。

        logger.i('検索Query: $query');
        return ref.watch(mapRepositoryProvider).searchFacilities(query, localeLanguage);
      }
    });
  }

  Future<void> geocoding(String facilityId, String name) async {
    final facility = await ref.watch(facilityRepositoryProvider).fetchFacility(facilityId);
    if (facility != null) {
      _selectedLocationInfoController.add(
        SelectedLocationInfo(
          facilityId: facilityId,
          name: name,
          latLng: LatLng(facility.geo.latitude, facility.geo.longitude),
          hasMeasurementResult: true,
        ),
      );
      return;
    }

    /// Firestoreに該当のデータがない場合はApiから取得する
    final location = await ref.watch(mapRepositoryProvider).geocoding(facilityId);
    _selectedLocationInfoController.add(
      SelectedLocationInfo(
        facilityId: facilityId,
        name: name,
        latLng: LatLng(location.latitude, location.longitude),
        hasMeasurementResult: false,
      ),
    );
  }
}
