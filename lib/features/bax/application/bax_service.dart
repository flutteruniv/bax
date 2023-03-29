import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/application/auth_service.dart';
import '../data/bax_repository.dart';

final myBaxHistoriesProvider = Provider(
  (ref) {
    final uid = ref.watch(uidProvider).valueOrNull;
    return ref.watch(baxHistoriesProvider(uid)).valueOrNull;
  },
);
