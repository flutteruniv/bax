import 'package:bax/configs/validators.dart';
import 'package:bax/features/load/application/scaffold_manager_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Validators validators;

  setUp(() {
    final container = ProviderContainer();
    validators = container.read(validatorsProvider);

    WidgetsFlutterBinding.ensureInitialized();
  });

  group('メールアドレスのValidationテスト', () {
    test('有効なメールアドレス', () {
      const email = 'bax@gmail.com';
      final actual = validators.validEmail(email);
      expect(actual, true);
    });
    test('空文字', () {
      const email = '';
      final actual = validators.validEmail(email);
      expect(actual, false);
    });
    test('無効なメールアドレス', () {
      const email = 'invalid#com';
      final actual = validators.validEmail(email);
      expect(actual, false);
    });
  });
}
