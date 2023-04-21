import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../payment/repository/payment_repository.dart';
import '../domain/bax.dart';

class BaxRewordDialog extends ConsumerStatefulWidget {
  const BaxRewordDialog({
    super.key,
    required this.bax,
  });
  final Bax bax;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaxRewordDialogState();
}

class _BaxRewordDialogState extends ConsumerState<BaxRewordDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('獲得したBAX'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...widget.bax.baxReasons.map(
                  (e) => Row(
                    children: [
                      Expanded(
                        child: Text(
                          e.text,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        '${e.point}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                if (ref.watch(isProProvider))
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Pro ブースト',
                          style: TextStyle(),
                        ),
                      ),
                      Text(
                        '×${widget.bax.bonusRate}',
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '合計',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${widget.bax.totalPoint}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
