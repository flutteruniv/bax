import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorDialog extends ConsumerWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AlertDialog(
      title: Text('エラー'),
    );
  }
}
