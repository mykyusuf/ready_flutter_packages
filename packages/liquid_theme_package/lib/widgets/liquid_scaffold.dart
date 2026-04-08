import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../theme/liquid_theme_extension.dart';

class LiquidScaffold extends StatelessWidget {
  const LiquidScaffold({
    required this.body,
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.themeOverride,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final LiquidThemeExtension? themeOverride;

  @override
  Widget build(BuildContext context) {
    final theme = themeOverride ?? LiquidThemeExtension.resolve(context);

    return AdaptiveLiquidGlassLayer(
      settings: theme.toLiquidGlassSettings(),
      quality: theme.quality,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
