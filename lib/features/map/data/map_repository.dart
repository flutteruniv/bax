import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/http.dart';
import '../../../configs/secrets.dart';
import '../domain/facility_prediction_results/facility_prediction_result.dart';
import '../domain/facility_prediction_results/facility_prediction_results.dart';
import '../domain/geocoding_results/geocoding_results.dart';
import '../domain/geometry/location.dart';
import '../domain/nearby_search_results/nearby_search_results.dart';

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
final nearbyFacilityProvider = FutureProvider.autoDispose.family((ref, GeoPoint geoPoint) async {
  final res = await ref.watch(mapRepositoryProvider).fetchNearByFacility(geoPoint);

  if (res.nextPageToken == null) {
    return res;
  }
  final nextPageRes = await ref.read(mapRepositoryProvider).fetchNearByFacility(
        geoPoint,
        nextPageToken: res.nextPageToken,
      );
  if (nextPageRes.nextPageToken == null) {
    return nextPageRes.copyWith(results: [...res.results, ...nextPageRes.results]);
  }
  final finalPageRes = await ref.read(mapRepositoryProvider).fetchNearByFacility(
        geoPoint,
        nextPageToken: nextPageRes.nextPageToken,
      );
  return finalPageRes.copyWith(
    results: [
      ...res.results,
      ...nextPageRes.results,
      ...finalPageRes.results,
    ],
  );
});

class MapRepository {
  MapRepository();

  final _predictionResultController = StreamController<List<FacilityPredictionResult>>();

  Stream<List<FacilityPredictionResult>> predictionResultStream() {
    return _predictionResultController.stream;
  }

  /// Reference: https://developers.google.com/maps/documentation/places/web-service/autocomplete?hl=ja
  Future<void> searchFacilities(
    String word,
    String localeLanguage, {
    GeoPoint? geoPoint,
  }) async {
    final queryParameters = {
      'input': word,
      'key': googleMapAPIKey,
      'language': localeLanguage,
    };

    if (geoPoint != null) {
      queryParameters.addAll(
        {
          'location': '${geoPoint.latitude} ${geoPoint.longitude}',
          'radius': '500',
        },
      );
    }

    await httpGet(
      uri: Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/autocomplete/json',
        queryParameters,
      ),
      responseBuilder: (data) {
        final results = FacilityPredictionResults.fromJson(data);
        _predictionResultController.add(results.predictions);
      },
    );
  }

  /// APIReference：https://developers.google.com/maps/documentation/places/web-service/search-nearby
  Future<NearbySearchResults> fetchNearByFacility(
    GeoPoint geoPoint, {
    String? nextPageToken,
  }) async {
    return httpGet<NearbySearchResults>(
      uri: Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/nearbysearch/json',
        {
          'location': '${geoPoint.latitude} ${geoPoint.longitude}',
          // 'radius': '50',
          // TODO(kenta-wakasa): 多言語対応のとき注意
          'language': 'ja',
          'key': googleMapAPIKey,

          'rankby': 'distance',
          // 'opennow': 'true',
          if (nextPageToken != null) 'pagetoken': nextPageToken,
        },
      ),
      responseBuilder: (data) {
        return NearbySearchResults.fromJson(data);
      },
    );
  }

  /// APIReference: https://developers.google.com/maps/documentation/geocoding/requests-geocoding
  Future<Location> geocoding(String facilityId) async {
    return await httpGet(
      uri: Uri.https(
        'maps.googleapis.com',
        '/maps/api/geocode/json',
        {'place_id': facilityId, 'key': googleMapAPIKey},
      ),
      responseBuilder: (data) {
        final results = GeocodingResults.fromJson(data);
        return results.results.first.geometry.location;
      },
    );
  }
}
