import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../theme/liquid_theme_extension.dart';

class LiquidBottomTab {
  const LiquidBottomTab({
    required this.label,
    required this.icon,
  });

  final String label;
  final Widget icon;
}

class LiquidBottomBar extends StatelessWidget {
  const LiquidBottomBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
    this.themeOverride,
    this.barHeight = 64,
    this.horizontalPadding = 20,
    this.verticalPadding = 16,
  });

  final List<LiquidBottomTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final LiquidThemeExtension? themeOverride;
  final double barHeight;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = themeOverride ?? LiquidThemeExtension.resolve(context);
    final glassTabs = tabs
        .map((tab) => GlassBottomBarTab(
              label: tab.label,
              icon: tab.icon,
            ))
        .toList(growable: false);

    return GlassBottomBar(
      tabs: glassTabs,
      selectedIndex: selectedIndex,
      onTabSelected: onTabSelected,
      barHeight: barHeight,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      barBorderRadius: theme.radius * 2,
      glassSettings: theme.toLiquidGlassSettings(),
      quality: theme.quality,
      selectedIconColor: theme.palette.accent,
      unselectedIconColor: theme.palette.accent.withValues(alpha: 0.7),
      indicatorColor: theme.palette.surface.withValues(alpha: 0.25),
    );
  }
}
