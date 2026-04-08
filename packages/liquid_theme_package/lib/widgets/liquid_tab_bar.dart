import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../theme/liquid_theme_extension.dart';

class LiquidTab {
  const LiquidTab({
    required this.label,
    this.icon,
  });

  final String label;
  final Widget? icon;
}

class LiquidTabBar extends StatelessWidget {
  const LiquidTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
    this.themeOverride,
    this.height = 48,
    this.isScrollable = false,
  });

  final List<LiquidTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final LiquidThemeExtension? themeOverride;
  final double height;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    final theme = themeOverride ?? LiquidThemeExtension.resolve(context);
    final glassTabs = tabs
        .map((tab) => GlassTab(
              icon: tab.icon,
              label: tab.label,
            ))
        .toList(growable: false);

    return GlassTabBar(
      tabs: glassTabs,
      selectedIndex: selectedIndex,
      onTabSelected: onTabSelected,
      height: height,
      isScrollable: isScrollable,
      borderRadius: BorderRadius.circular(theme.radius),
      indicatorBorderRadius: BorderRadius.circular(theme.radius - 2),
      settings: theme.toLiquidGlassSettings(),
      useOwnLayer: true,
      quality: theme.quality,
      selectedIconColor: theme.palette.accent,
      unselectedIconColor: theme.palette.accent.withValues(alpha: 0.65),
      selectedLabelStyle: TextStyle(
        color: theme.palette.accent,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        color: theme.palette.accent.withValues(alpha: 0.65),
        fontWeight: FontWeight.w500,
      ),
      indicatorColor: theme.palette.surface.withValues(alpha: 0.3),
    );
  }
}
