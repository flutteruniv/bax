import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/application/auth_service.dart';
import '../../user/application/user_service.dart';
import '../data/bax_repository.dart';

final myBaxHistoriesProvider = Provider(
  (ref) {
    final uid = ref.watch(uidProvider);
    return ref.watch(baxHistoriesProvider(uid)).valueOrNull;
  },
);

/// baxを使えるかどうか
final canUseBax = Provider((ref) {
  final email = ref.watch(authStateChangesProvider).valueOrNull?.email;
  final bax = ref.watch(userBaxProvider);
  return email != null && bax >= 500;
});
