import 'dart:async';
import 'dart:convert';

import 'package:bax/configs/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../configs/secrets.dart';
import '../domain/facility_prediction_result.dart';
import '../domain/facility_prediction_results.dart';

final predictionResultStreamProvider = StreamProvider(
  (ref) {
    return ref.watch(mapRepositoryProvider).predictionResultStream();
  },
);

final mapRepositoryProvider = Provider(
  (ref) => MapRepository(),
);

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

        /// Todo: ロガーを使う
        print('results: ${results}');
        _predictionResultController.add(results.predictions);
      },
    );
  }
}
