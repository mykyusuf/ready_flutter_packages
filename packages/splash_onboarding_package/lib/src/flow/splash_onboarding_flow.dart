import 'package:flutter/material.dart';

import '../models/onboarding_page_data.dart';
import '../screens/onboarding_screen.dart';
import '../screens/splash_screen.dart';

class SplashOnboardingFlow extends StatefulWidget {
  const SplashOnboardingFlow({
    required this.pages,
    required this.onFinished,
    super.key,
    this.splashDuration = const Duration(seconds: 2),
    this.splashTitle = 'Welcome',
    this.splashSubtitle = 'Preparing your experience',
    this.splashLogo,
  });

  final List<OnboardingPageData> pages;
  final VoidCallback onFinished;
  final Duration splashDuration;
  final String splashTitle;
  final String splashSubtitle;
  final Widget? splashLogo;

  @override
  State<SplashOnboardingFlow> createState() => _SplashOnboardingFlowState();
}

class _SplashOnboardingFlowState extends State<SplashOnboardingFlow> {
  bool _showOnboarding = false;

  @override
  Widget build(BuildContext context) {
    if (!_showOnboarding) {
      return SplashScreen(
        duration: widget.splashDuration,
        title: widget.splashTitle,
        subtitle: widget.splashSubtitle,
        logo: widget.splashLogo,
        onFinished: () {
          if (mounted) {
            setState(() => _showOnboarding = true);
          }
        },
      );
    }

    return OnboardingScreen(
      pages: widget.pages,
      onDone: widget.onFinished,
      onSkip: widget.onFinished,
    );
  }
}
