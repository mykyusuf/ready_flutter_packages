import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../theme/liquid_theme_extension.dart';

class LiquidButton extends StatelessWidget {
  const LiquidButton({
    required this.child,
    required this.onTap,
    super.key,
    this.width = 140,
    this.height = 48,
    this.enabled = true,
    this.useOwnLayer = true,
    this.themeOverride,
    this.shape,
    this.glassButtonStyle = GlassButtonStyle.filled,
    this.label = '',
  });

  final Widget child;
  final VoidCallback onTap;
  final double width;
  final double height;
  final bool enabled;
  final bool useOwnLayer;
  final LiquidThemeExtension? themeOverride;
  final LiquidShape? shape;
  final GlassButtonStyle glassButtonStyle;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = themeOverride ?? LiquidThemeExtension.resolve(context);
    final effectiveShape =
        shape ?? LiquidRoundedSuperellipse(borderRadius: theme.radius);

    final themedChild = IconTheme(
      data: IconThemeData(color: theme.palette.accent),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: theme.palette.accent,
          fontWeight: FontWeight.w600,
        ),
        child: child,
      ),
    );

    return GlassButton.custom(
      onTap: enabled ? onTap : () {},
      enabled: enabled,
      width: width,
      height: height,
      label: label,
      shape: effectiveShape,
      settings: theme.toLiquidGlassSettings(),
      useOwnLayer: useOwnLayer,
      quality: theme.quality,
      glowColor: theme.palette.glow,
      style: glassButtonStyle,
      child: themedChild,
    );
  }
}
