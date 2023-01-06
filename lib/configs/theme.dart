import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider((_) => _defaultTheme);

final _defaultTheme = ThemeData.dark();
