import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/localizations.dart';

class ErrorDialog extends ConsumerWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(localizationsProvider);
    return AlertDialog(
      title: Text(l.error),
    );
  }
}
