import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// FirebaseFirestore(データベース)プロバイダー
final firebaseFirestoreProvider = Provider(
  (ref) => FirebaseFirestore.instance,
);
