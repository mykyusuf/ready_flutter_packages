import 'package:flutter/material.dart';

import '../models/liquid_theme_palette.dart';
import 'liquid_theme_extension.dart';

final class LiquidThemePresets {
  const LiquidThemePresets._();

  static const LiquidThemeExtension light = LiquidThemeExtension(
    palette: LiquidThemePalette(
      surface: Color(0x66FFFFFF),
      accent: Color(0xFF1B6EF3),
      border: Color(0x99FFFFFF),
      glow: Color(0x80FFFFFF),
    ),
    opacity: 0.2,
    thickness: 28,
    blur: 4,
    lightIntensity: 0.9,
    ambientStrength: 0.24,
    refractiveIndex: 1.13,
    saturation: 1.18,
    radius: 16,
    borderWidth: 1,
  );

  static const LiquidThemeExtension dark = LiquidThemeExtension(
    palette: LiquidThemePalette(
      surface: Color(0x331A2236),
      accent: Color(0xFF8AB4FF),
      border: Color(0x66FFFFFF),
      glow: Color(0x66AECBFA),
    ),
    opacity: 0.28,
    thickness: 36,
    blur: 5,
    lightIntensity: 0.7,
    ambientStrength: 0.16,
    refractiveIndex: 1.2,
    saturation: 1.1,
    radius: 16,
    borderWidth: 1.2,
  );

  static const LiquidThemeExtension highContrast = LiquidThemeExtension(
    palette: LiquidThemePalette(
      surface: Color(0x7F000000),
      accent: Color(0xFFFFFFFF),
      border: Color(0xFFFFFFFF),
      glow: Color(0xCCFFFFFF),
    ),
    opacity: 0.4,
    thickness: 34,
    blur: 2.5,
    lightIntensity: 1,
    ambientStrength: 0.3,
    refractiveIndex: 1.12,
    saturation: 1,
    radius: 14,
    borderWidth: 1.5,
  );

  static LiquidThemeExtension fromSeed(
    Color seed, {
    Brightness brightness = Brightness.light,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );

    if (brightness == Brightness.dark) {
      return dark.copyWith(
        palette: LiquidThemePalette(
          surface: scheme.surface.withValues(alpha: 0.42),
          accent: scheme.primary,
          border: scheme.outlineVariant.withValues(alpha: 0.75),
          glow: scheme.primary.withValues(alpha: 0.6),
        ),
      );
    }

    return light.copyWith(
      palette: LiquidThemePalette(
        surface: scheme.surface.withValues(alpha: 0.55),
        accent: scheme.primary,
        border: scheme.outlineVariant.withValues(alpha: 0.75),
        glow: scheme.primary.withValues(alpha: 0.45),
      ),
    );
  }
}
