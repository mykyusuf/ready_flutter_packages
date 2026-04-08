import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

import '../models/onboarding_page_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    required this.pages,
    required this.onDone,
    super.key,
    this.onSkip,
    this.doneLabel = 'Get Started',
    this.nextLabel = 'Next',
    this.skipLabel = 'Skip',
  });

  final List<OnboardingPageData> pages;
  final VoidCallback onDone;
  final VoidCallback? onSkip;
  final String doneLabel;
  final String nextLabel;
  final String skipLabel;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _index = 0;

  bool get _isLastPage => _index == widget.pages.length - 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _triggerHaptic(Future<void> Function() action) {
    action().catchError((_) {
      // Ignore haptic errors on unsupported platforms/test environments.
    });
  }

  void _onSkipTap() {
    _triggerHaptic(HapticFeedback.selectionClick);
    (widget.onSkip ?? widget.onDone).call();
  }

  void _onNextTap() {
    if (_isLastPage) {
      _triggerHaptic(HapticFeedback.lightImpact);
      widget.onDone();
      return;
    }
    _triggerHaptic(HapticFeedback.selectionClick);
    _next();
  }

  void _next() {
    if (_isLastPage) {
      widget.onDone();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.pages.isNotEmpty, 'Onboarding pages cannot be empty.');
    final scheme = Theme.of(context).colorScheme;
    final buttonShape = const LiquidRoundedSuperellipse(borderRadius: 32);
    final buttonSettings = LiquidGlassSettings(
      visibility: 1,
      glassColor: scheme.surface.withValues(alpha: 0.35),
      blur: 8,
      thickness: 26,
      lightIntensity: 0.7,
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.pages.length,
              onPageChanged: (value) => setState(() => _index = value),
              itemBuilder: (context, pageIndex) {
                final page = widget.pages[pageIndex];
                if (page.child != null) {
                  return SizedBox.expand(child: page.child!);
                }
                return GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(page.icon, size: 64),
                        const SizedBox(height: 20),
                        Text(
                          page.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          page.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              minimum: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.pages.length, (dotIndex) {
                      final isActive = dotIndex == _index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GlassButton.custom(
                          onTap: _onSkipTap,
                          shape: buttonShape,
                          settings: buttonSettings,
                          style: GlassButtonStyle.filled,
                          child: Text(widget.skipLabel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GlassButton.custom(
                          onTap: _onNextTap,
                          shape: buttonShape,
                          settings: buttonSettings,
                          style: GlassButtonStyle.filled,
                          child: Text(_isLastPage ? widget.doneLabel : widget.nextLabel),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
