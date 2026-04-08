# splash_onboarding_package

Reusable splash and onboarding flow package with liquid glass UI.

## Installation

```yaml
dependencies:
  splash_onboarding_package:
    git:
      url: https://github.com/mykyusuf/ready_flutter_packages.git
      ref: main
      path: packages/splash_onboarding_package
```

## Startup

```dart
import 'package:flutter/material.dart';
import 'package:splash_onboarding_package/splash_onboarding_package.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  runApp(LiquidGlassWidgets.wrap(const MyApp()));
}
```

## Splash + onboarding flow

```dart
final pages = const [
  OnboardingPageData(
    title: 'Welcome',
    description: 'Discover the app in a few steps.',
    icon: Icons.waving_hand_rounded,
  ),
  OnboardingPageData(
    title: 'Personalize',
    description: 'Tune your preferences quickly.',
    icon: Icons.tune_rounded,
  ),
  OnboardingPageData(
    title: 'Ready',
    description: 'Start using all features.',
    icon: Icons.rocket_launch_rounded,
  ),
];

SplashOnboardingFlow(
  pages: pages,
  onFinished: () {
    // Navigate to home
  },
)
```

## Single screen usage

You can also use screens separately:

- `SplashScreen`
- `OnboardingScreen`
