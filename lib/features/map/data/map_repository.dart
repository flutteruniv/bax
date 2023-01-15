import 'dart:async';
import 'dart:convert';

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
    // ToDo ちゃんとClient設計したい
    final response = await http.get(
      Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/autocomplete/json',
        {'input': word, 'types': 'lodging', 'key': googleMapAPIKey, 'language': localeLanguage},

        /// Todo: languageにOSの言語を設定したい。jaを設定しないと住所だけ英語で返ってくる
      ),
    );
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    final results = FacilityPredictionResults.fromJson(jsonResponse);
    print('results: ${results}');
    _predictionResultController.add(results.predictions);
  }
}
