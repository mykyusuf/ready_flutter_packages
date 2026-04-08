import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

void main() {
  testWidgets('re-exported liquid_glass_widgets types are usable', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              const GlassCard(child: Text('Card')),
              GlassButton.custom(onTap: () {}, child: const Text('Button')),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(GlassCard), findsOneWidget);
    expect(find.byType(GlassButton), findsOneWidget);
  });
}
