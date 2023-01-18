import 'dart:async';

import 'package:bax/features/facility/data/facility_repository.dart';
import 'package:bax/features/map/data/map_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/selected_location_info.dart';

/// ユーザーが施設予測結果から選択したときにロケーション情報が返される[StreamProvider]
final selectedLocationInfoStreamProvider = StreamProvider(
  (ref) {
    return ref.watch(mapServiceProvider).locationInfoStream();
  },
);

final mapServiceProvider = Provider((ref) {
  return MapService(ref);
});

class MapService {
  MapService(this.ref);

  final Ref ref;

  /// 保留中の検索文字列
  String? _holdQuery;

  final _locationInfoController = StreamController<SelectedLocationInfo>();

  Stream<SelectedLocationInfo> locationInfoStream() {
    return _locationInfoController.stream;
  }

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

  Future<void> geocoding(String facilityId, String name) async {
    final locationFromFirestore = await ref.watch(facilityRepositoryProvider).fetchLocation(facilityId);
    if (locationFromFirestore != null) {
      _locationInfoController.add(
        SelectedLocationInfo(
          facilityId: facilityId,
          name: name,
          latLng: LatLng(locationFromFirestore.latitude, locationFromFirestore.longitude),
          hasMeasurementResult: true,
        ),
      );
      return;
    }
    final locationFromApi = await ref.watch(mapRepositoryProvider).geocoding(facilityId);
    _locationInfoController.add(
      SelectedLocationInfo(
        facilityId: facilityId,
        name: name,
        latLng: LatLng(locationFromApi.latitude, locationFromApi.longitude),
        hasMeasurementResult: false,
      ),
    );
  }
}
