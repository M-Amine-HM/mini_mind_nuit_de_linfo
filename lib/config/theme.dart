import 'package:flutter/material.dart';
import 'package:mini_mind_nuit_de_linfo/config/colors/colors.dart';
import '../config/colors/colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  fontFamily: 'Roboto',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
);
