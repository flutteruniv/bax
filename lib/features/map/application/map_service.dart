import 'dart:developer';

import 'package:bax/features/facility/data/facility_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final facilitiesProvider = StreamProvider.autoDispose(
  (ref) {
    return ref.watch(facilityRepositoryProvider).changesFacilities();
  },
);

final mapServiceProvider = Provider((ref) {
  return MapService(ref);
});

class MapService {
  MapService(this.ref);

  final Ref ref;

  /// 施設情報取得
  Future<void> fetchFacilities() async {
    final repository = ref.read(facilityRepositoryProvider);
    final facilities = await repository.fetchFacilities();
    return repository.updateFacilities(facilities);
  }
}
