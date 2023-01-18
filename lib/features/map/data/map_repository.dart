import 'dart:async';

import 'package:bax/configs/http.dart';
import 'package:bax/features/map/domain/nearby_search_results/nearby_search_results.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/secrets.dart';
import '../domain/facility_prediction_results/facility_prediction_result.dart';
import '../domain/facility_prediction_results/facility_prediction_results.dart';

/// searchFacilitiesが実行される度に予測結果が更新される[StreamProvider]
final predictionResultStreamProvider = StreamProvider(
  (ref) {
    return ref.watch(mapRepositoryProvider).predictionResultStream();
  },
);

final mapRepositoryProvider = Provider(
  (ref) => MapRepository(),
);

/// [GeoPoint]を引数として与え、近くの施設を検索して結果を返す[FutureProvider]
final nearbyFacilityProvider = FutureProvider.autoDispose.family((ref, GeoPoint geoPoint) {
  return ref.watch(mapRepositoryProvider).fetchNearByFacility(geoPoint);
});

class MapRepository {
  MapRepository();

  final _predictionResultController = StreamController<List<FacilityPredictionResult>>();

  Stream<List<FacilityPredictionResult>> predictionResultStream() {
    return _predictionResultController.stream;
  }

  Future<void> searchFacilities(String word, String localeLanguage) async {
    await httpGet(
      uri: Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/autocomplete/json',
        {'input': word, 'types': 'lodging', 'key': googleMapAPIKey, 'language': localeLanguage},
      ),
      responseBuilder: (data) {
        final results = FacilityPredictionResults.fromJson(data);

        /// TODO: ロガーを使う
        print('results: $results');
        _predictionResultController.add(results.predictions);
      },
    );
  }

  /// APIReference：https://developers.google.com/maps/documentation/places/web-service/search-nearby
  Future<NearbySearchResults> fetchNearByFacility(GeoPoint geoPoint) async {
    return httpGet<NearbySearchResults>(
      uri: Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/nearbysearch/json',
        {
          'location': '${geoPoint.latitude} ${geoPoint.longitude}',
          'radius': '10',
          // TODO(kenta-wakasa): 多言語対応のとき注意
          'language': 'ja',
          // TODO(kenta-wakasa): typeで絞り込みかけた方がいいかも
          'key': googleMapAPIKey,
        },
      ),
      responseBuilder: (data) {
        return NearbySearchResults.fromJson(data);
      },
    );
  }
}
