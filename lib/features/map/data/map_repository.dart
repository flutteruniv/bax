import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../configs/secrets.dart';
import '../domain/facility_prediction_results.dart';

final mapRepositoryProvider = Provider(
  (ref) => MapRepository(),
);

class MapRepository {
  MapRepository();

  Future<void> searchFacilities(String word) async {
    // ToDo ちゃんとClient設計したい
    final response = await http.get(
      Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/autocomplete/json',
        {'input': word, 'types': 'lodging', 'key': googleMapAPIKey, 'language': 'ja'},

        /// Todo: languageにOSの言語を設定したい。jaを設定しないと住所だけ英語で返ってくる
      ),
    );
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    final results = FacilityPredictionResults.fromJson(jsonResponse);
    print('results: ${results}');
  }
}
