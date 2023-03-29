import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/application/auth_service.dart';
import '../data/user_repository.dart';

final loginUserProvider = StreamProvider((ref) {
  final uid = ref.watch(uidProvider).valueOrNull;
  return ref.read(userRepositoryProvider).streamUser(uid);
});

/// userのbaxを返す。
final userBaxProvider = Provider<double>((ref) {
  return ref.watch(loginUserProvider).valueOrNull?.data()?.baxPoint ?? 0.0;
});
