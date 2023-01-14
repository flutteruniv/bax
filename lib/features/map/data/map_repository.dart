import 'dart:async';
import 'dart:convert';

import 'package:bax/configs/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../configs/secrets.dart';

final mapRepositoryProvider = Provider(
  (ref) => MapRepository(),
);

class MapRepository {
  MapRepository();

  Future<void> searchFacilities(String word) async {
    // ToDo ちゃんとClient設計したい
    print(googleMapAPIKey);
    print(word);
    final response = await http.get(
      Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/autocomplete/json',
        {'input': word, 'types': 'lodging', 'key': googleMapAPIKey},
      ),
    );
    final jsonResponse = jsonDecode(response.body);
    print('json: ${jsonResponse}');
  }
}
