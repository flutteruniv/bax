import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

import '../../../configs/localizations.dart';
import '../../../configs/logger.dart';
import '../../facility/data/facility_repository.dart';
import '../../facility/domain/facility.dart';
import '../../location/domain/my_location.dart';
import '../data/map_repository.dart';
import '../domain/common_searched_facility.dart';

final commonSearchedFacilitiesNotifierProvider =
    NotifierProvider.autoDispose<CommonSearchedFacilitiesNotifier, List<CommonSearchedFacility>>(
  CommonSearchedFacilitiesNotifier.new,
);

class CommonSearchedFacilitiesNotifier extends AutoDisposeNotifier<List<CommonSearchedFacility>> {
  @override
  List<CommonSearchedFacility> build() {
    return [];
  }

  /// 保留中の検索文字列
  String? _holdQuery;

  Future<void> fetchNearbyFacility() async {
    final location = await ref.read(locationProvider.future);
    if (location == null) {
      return;
    }
    final nearbySearchResults = await ref.read(mapRepositoryProvider).fetchNearByFacility(
          GeoPoint(
            location.latitude,
            location.longitude,
          ),
        );

    state = nearbySearchResults.results
        .map(
          (e) => CommonSearchedFacility(
            placeId: e.placeId,
            name: e.name,
            // TODO(kenta-wakasa): vicinityでいいのか？
            address: e.vicinity,
          ),
        )
        .toList();
  }

  Future<void> searchFacilities(String query) async {
    _holdQuery = query;
    final location = await ref.read(locationProvider.future);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (_holdQuery == query) {
      logger.i('検索Query: $query');
      final facilityPredictionResults = await ref.read(mapRepositoryProvider).searchFacilities(
            query,
            ref.read(localeProvider).languageCode.split('_').first,
            geoPoint: location == null
                ? null
                : GeoPoint(
                    location.latitude,
                    location.longitude,
                  ),
          );
      state = facilityPredictionResults.predictions
          .map(
            (e) => CommonSearchedFacility(
              placeId: e.placeId,
              name: e.resultFormatting.name,
              address: e.resultFormatting.address,
            ),
          )
          .toList();
    }
  }

  void clear() {
    state = [];
  }
}

final selectedFacilityNotifierProvider =
    NotifierProvider.autoDispose<SelectedFacilityNotifier, Facility?>(SelectedFacilityNotifier.new);

class SelectedFacilityNotifier extends AutoDisposeNotifier<Facility?> {
  @override
  Facility? build() {
    return null;
  }

  // TODO(kenta-wakasa): 名前を変えた方がいい
  Future<void> geocoding(String facilityId, String name, String address) async {
    ref.read(commonSearchedFacilitiesNotifierProvider.notifier).clear();

    final facility = await ref.watch(facilityRepositoryProvider).fetchFacility(facilityId);
    if (facility != null) {
      state = facility.data();
      return;
    }

    /// Firestoreに該当のデータがない場合はApiから取得する
    final location = await ref.watch(mapRepositoryProvider).geocoding(facilityId);
    final newFacility = Facility(
      id: facilityId,
      name: name,
      geo: GeoFirePoint(
        GeoPoint(
          location.latitude,
          location.longitude,
        ),
      ),
      address: address,
      downloadSpeed: 0,
      uploadSpeed: 0,
      docRef: ref.read(facilityRepositoryProvider).facilityCollectionReference.doc(facilityId),
    );

    /// Firestoreに保存
    await newFacility.docRef.set(newFacility);
    state = newFacility;
  }
}
