import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../theme/liquid_theme_extension.dart';

class LiquidCard extends StatelessWidget {
  const LiquidCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.width,
    this.height,
    this.useOwnLayer = true,
    this.themeOverride,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool useOwnLayer;
  final LiquidThemeExtension? themeOverride;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = themeOverride ?? LiquidThemeExtension.resolve(context);
    final shape = LiquidRoundedSuperellipse(borderRadius: theme.radius);

    final decoratedChild = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.radius),
        border: Border.all(
          color: theme.palette.border,
          width: theme.borderWidth,
        ),
      ),
      child: child,
    );

    return GlassCard(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      shape: shape,
      settings: theme.toLiquidGlassSettings(),
      useOwnLayer: useOwnLayer,
      quality: theme.quality,
      clipBehavior: clipBehavior,
      child: decoratedChild,
    );
  }
}
