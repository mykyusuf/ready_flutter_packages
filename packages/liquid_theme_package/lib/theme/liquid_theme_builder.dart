import 'package:flutter/material.dart';

import 'liquid_theme_extension.dart';
import 'liquid_theme_presets.dart';

extension LiquidThemeBuilder on ThemeData {
  ThemeData withLiquidTheme([LiquidThemeExtension? extension]) {
    final targetExtension =
        extension ??
        (brightness == Brightness.dark
            ? LiquidThemePresets.dark
            : LiquidThemePresets.light);

    final extensionList = List<ThemeExtension<dynamic>>.from(extensions.values);
    extensionList.removeWhere((item) => item is LiquidThemeExtension);
    extensionList.add(targetExtension);

    return copyWith(extensions: extensionList);
  }
}
