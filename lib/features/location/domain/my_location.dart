import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final _locationProvider = Provider((_) => Location());

// TODO(kenta-wakasa): 権限要求
final locationDataProvider = StreamProvider((ref) {
  return ref.watch(_locationProvider).onLocationChanged;
});
