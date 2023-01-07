import 'package:bax/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = Provider((_) => baxTheme);

final defaultTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: BaxColor.primaryColor,
    secondary: BaxColor.secondaryColor,
  ),
  primaryColor: BaxColor.primaryColor,
  fontFamily: 'NotoSansJP',
);

final baxTheme = defaultTheme.copyWith(
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
