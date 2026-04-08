import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:splash_onboarding_package/splash_onboarding_package.dart';

void main() {
  testWidgets('SplashScreen renders and triggers callback', (tester) async {
    var finished = false;

    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(
          duration: Duration.zero,
          title: 'Splash Title',
          subtitle: 'Splash Subtitle',
          onFinished: () => finished = true,
        ),
      ),
    );

    expect(find.text('Splash Title'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1));
    expect(finished, isTrue);
  });

  testWidgets('OnboardingScreen moves to next page', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: OnboardingScreen(
          pages: const [
            OnboardingPageData(
              title: 'Page 1',
              description: 'Description 1',
              icon: Icons.looks_one_rounded,
            ),
            OnboardingPageData(
              title: 'Page 2',
              description: 'Description 2',
              icon: Icons.looks_two_rounded,
            ),
          ],
          onDone: () {},
        ),
      ),
    );

    expect(find.text('Page 1'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Page 2'), findsOneWidget);
  });
}
