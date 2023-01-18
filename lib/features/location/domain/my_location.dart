import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final _locationProvider = Provider((_) => Location());

final locationDataProvider = StreamProvider((ref) {
  return ref.watch(_locationProvider).onLocationChanged;
});
