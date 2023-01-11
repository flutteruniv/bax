import 'package:bax/features/facility/data/facility_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final facilitiesStreamProvider = StreamProvider.autoDispose(
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

  void setupMap() {
    ref.read(facilityRepositoryProvider).monitorFacility();
  }
}
