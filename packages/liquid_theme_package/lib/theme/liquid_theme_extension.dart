import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../models/liquid_theme_palette.dart';
import 'liquid_theme_presets.dart';

@immutable
class LiquidThemeExtension extends ThemeExtension<LiquidThemeExtension> {
  const LiquidThemeExtension({
    required this.palette,
    this.opacity = 0.22,
    this.thickness = 30,
    this.blur = 4,
    this.chromaticAberration = 0.01,
    this.lightAngle = 3.14,
    this.lightIntensity = 0.85,
    this.ambientStrength = 0.2,
    this.refractiveIndex = 1.15,
    this.saturation = 1.2,
    this.radius = 16,
    this.borderWidth = 1,
    this.quality = GlassQuality.standard,
  });

  final LiquidThemePalette palette;
  final double opacity;
  final double thickness;
  final double blur;
  final double chromaticAberration;
  final double lightAngle;
  final double lightIntensity;
  final double ambientStrength;
  final double refractiveIndex;
  final double saturation;
  final double radius;
  final double borderWidth;
  final GlassQuality quality;

  static LiquidThemeExtension resolve(BuildContext context) {
    final theme = Theme.of(context).extension<LiquidThemeExtension>();
    if (theme != null) {
      return theme;
    }

    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LiquidThemePresets.dark
        : LiquidThemePresets.light;
  }

  LiquidGlassSettings toLiquidGlassSettings() {
    return LiquidGlassSettings(
      glassColor: palette.surface.withValues(alpha: opacity),
      thickness: thickness,
      blur: blur,
      chromaticAberration: chromaticAberration,
      lightAngle: lightAngle,
      lightIntensity: lightIntensity,
      ambientStrength: ambientStrength,
      refractiveIndex: refractiveIndex,
      saturation: saturation,
    );
  }

  @override
  LiquidThemeExtension copyWith({
    LiquidThemePalette? palette,
    double? opacity,
    double? thickness,
    double? blur,
    double? chromaticAberration,
    double? lightAngle,
    double? lightIntensity,
    double? ambientStrength,
    double? refractiveIndex,
    double? saturation,
    double? radius,
    double? borderWidth,
    GlassQuality? quality,
  }) {
    return LiquidThemeExtension(
      palette: palette ?? this.palette,
      opacity: opacity ?? this.opacity,
      thickness: thickness ?? this.thickness,
      blur: blur ?? this.blur,
      chromaticAberration: chromaticAberration ?? this.chromaticAberration,
      lightAngle: lightAngle ?? this.lightAngle,
      lightIntensity: lightIntensity ?? this.lightIntensity,
      ambientStrength: ambientStrength ?? this.ambientStrength,
      refractiveIndex: refractiveIndex ?? this.refractiveIndex,
      saturation: saturation ?? this.saturation,
      radius: radius ?? this.radius,
      borderWidth: borderWidth ?? this.borderWidth,
      quality: quality ?? this.quality,
    );
  }

  @override
  LiquidThemeExtension lerp(
    covariant ThemeExtension<LiquidThemeExtension>? other,
    double t,
  ) {
    if (other is! LiquidThemeExtension) {
      return this;
    }

    return LiquidThemeExtension(
      palette: LiquidThemePalette.lerp(palette, other.palette, t),
      opacity: lerpDouble(opacity, other.opacity, t) ?? opacity,
      thickness: lerpDouble(thickness, other.thickness, t) ?? thickness,
      blur: lerpDouble(blur, other.blur, t) ?? blur,
      chromaticAberration:
          lerpDouble(chromaticAberration, other.chromaticAberration, t) ??
          chromaticAberration,
      lightAngle: lerpDouble(lightAngle, other.lightAngle, t) ?? lightAngle,
      lightIntensity:
          lerpDouble(lightIntensity, other.lightIntensity, t) ?? lightIntensity,
      ambientStrength:
          lerpDouble(ambientStrength, other.ambientStrength, t) ??
          ambientStrength,
      refractiveIndex:
          lerpDouble(refractiveIndex, other.refractiveIndex, t) ??
          refractiveIndex,
      saturation: lerpDouble(saturation, other.saturation, t) ?? saturation,
      radius: lerpDouble(radius, other.radius, t) ?? radius,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      quality: t < 0.5 ? quality : other.quality,
    );
  }
}
