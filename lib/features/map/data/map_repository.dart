import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/http.dart';
import '../../../configs/localizations.dart';
import '../../../configs/secrets.dart';
import '../domain/facility_prediction_results/facility_prediction_results.dart';
import '../domain/geocoding_results/geocoding_results.dart';
import '../domain/geometry/location.dart';
import '../domain/nearby_search_results/nearby_search_results.dart';

final mapRepositoryProvider = Provider(MapRepository.new);

class MapRepository {
  MapRepository(this.ref);
  final Ref ref;

  /// Reference: https://developers.google.com/maps/documentation/places/web-service/autocomplete?hl=ja
  Future<FacilityPredictionResults> searchFacilities(
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

    return httpGet<FacilityPredictionResults>(
      uri: Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/autocomplete/json',
        queryParameters,
      ),
      responseBuilder: (data) {
        final results = FacilityPredictionResults.fromJson(data);
        return results;
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
          'language': ref.read(localeProvider).languageCode.split('_').first,
          'key': googleMapAPIKey,
          'rankby': 'distance',
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
    return httpGet(
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
