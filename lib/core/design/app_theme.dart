import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.surface,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.aqua,
      brightness: Brightness.light,
      primary: AppColors.aqua,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.leagueSpartanTextTheme().apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      filled: true,
      fillColor: AppColors.ice,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1),
  );
}
