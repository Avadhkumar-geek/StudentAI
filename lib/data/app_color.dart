import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? kSecondaryColor;
  final Color? kTertiaryColor;
  final Color? kTextColor;

  const AppColors({
    required this.kSecondaryColor,
    required this.kTertiaryColor,
    required this.kTextColor,
  });

  @override
  AppColors copyWith({
    Color? kSecondaryColor,
    Color? kTertiaryColor,
    Color? kTextColor,
  }) {
    return AppColors(
      kSecondaryColor: kSecondaryColor ?? this.kSecondaryColor,
      kTertiaryColor: kTertiaryColor ?? this.kTertiaryColor,
      kTextColor: kTextColor ?? this.kTextColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      kSecondaryColor: Color.lerp(kSecondaryColor, other.kSecondaryColor, t),
      kTertiaryColor: Color.lerp(kTertiaryColor, other.kTertiaryColor, t),
      kTextColor: Color.lerp(kTextColor, other.kTextColor, t),
    );
  }
}
