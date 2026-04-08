import 'package:flutter/material.dart';

@immutable
class LiquidThemePalette {
  const LiquidThemePalette({
    required this.surface,
    required this.accent,
    required this.border,
    required this.glow,
  });

  final Color surface;
  final Color accent;
  final Color border;
  final Color glow;

  LiquidThemePalette copyWith({
    Color? surface,
    Color? accent,
    Color? border,
    Color? glow,
  }) {
    return LiquidThemePalette(
      surface: surface ?? this.surface,
      accent: accent ?? this.accent,
      border: border ?? this.border,
      glow: glow ?? this.glow,
    );
  }

  static LiquidThemePalette lerp(
    LiquidThemePalette a,
    LiquidThemePalette b,
    double t,
  ) {
    return LiquidThemePalette(
      surface: Color.lerp(a.surface, b.surface, t) ?? a.surface,
      accent: Color.lerp(a.accent, b.accent, t) ?? a.accent,
      border: Color.lerp(a.border, b.border, t) ?? a.border,
      glow: Color.lerp(a.glow, b.glow, t) ?? a.glow,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiquidThemePalette &&
          runtimeType == other.runtimeType &&
          surface == other.surface &&
          accent == other.accent &&
          border == other.border &&
          glow == other.glow;

  @override
  int get hashCode => Object.hash(surface, accent, border, glow);
}
