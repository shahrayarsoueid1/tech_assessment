import 'package:flutter/material.dart';

ThemeData light() {
  final ThemeData defaultTheme = ThemeData.light(useMaterial3: true);
  return defaultTheme.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.0,
      iconTheme: IconThemeData(
        size: 24,
        color: Colors.black,
      ),
    ),
  );
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}
