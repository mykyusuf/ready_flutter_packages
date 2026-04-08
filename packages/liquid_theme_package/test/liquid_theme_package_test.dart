import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:liquid_theme_package/liquid_theme_package.dart';

void main() {
  test('LiquidThemeExtension copyWith and lerp works', () {
    const base = LiquidThemePresets.light;
    final updated = base.copyWith(radius: 20, opacity: 0.3);

    expect(updated.radius, 20);
    expect(updated.opacity, 0.3);

    final mixed = base.lerp(LiquidThemePresets.dark, 0.5);
    expect(mixed.thickness, isNot(base.thickness));
    expect(mixed.palette.surface, isNot(base.palette.surface));
  });

  test('preset factory fromSeed returns themed values', () {
    final light = LiquidThemePresets.fromSeed(const Color(0xFF4F46E5));
    final dark = LiquidThemePresets.fromSeed(
      const Color(0xFF4F46E5),
      brightness: Brightness.dark,
    );

    expect(light.palette.accent, isNot(dark.palette.accent));
    expect(dark.thickness, greaterThan(light.thickness));
  });

  testWidgets('resolve returns fallback without extension', (tester) async {
    late LiquidThemeExtension resolved;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Builder(
          builder: (context) {
            resolved = LiquidThemeExtension.resolve(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(resolved, LiquidThemePresets.light);
  });

  testWidgets('LiquidCard and LiquidButton render with theme extension', (
    tester,
  ) async {
    final theme = ThemeData.light().withLiquidTheme(LiquidThemePresets.light);

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Column(
            children: [
              const LiquidCard(child: Text('Card')),
              LiquidButton(onTap: () {}, child: const Text('Button')),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(LiquidCard), findsOneWidget);
    expect(find.byType(LiquidButton), findsOneWidget);
    expect(find.byType(GlassCard), findsOneWidget);
    expect(find.byType(GlassButton), findsOneWidget);
  });
}
