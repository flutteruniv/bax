import 'package:bax/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = Provider((_) => baxTheme);

final defaultTheme = ThemeData(
  colorScheme: const ColorScheme.light(primary: BaxColor.primaryColor),
  primaryColor: BaxColor.primaryColor,
  fontFamily: 'NotoSansJP',
);

final baxTheme = defaultTheme.copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      minimumSize: const Size(240, 40),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(240, 40),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
