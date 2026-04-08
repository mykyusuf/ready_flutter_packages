import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

import '../models/onboarding_page_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    required this.pages,
    required this.onDone,
    super.key,
    this.background,
    this.pageColors,
    this.buttonTextColor = Colors.white,
    this.onSkip,
    this.doneLabel = 'Get Started',
    this.nextLabel = 'Next',
    this.skipLabel = 'Skip',
  });

  final List<OnboardingPageData> pages;
  final VoidCallback onDone;
  final Widget? background;
  final List<Color>? pageColors;
  final Color buttonTextColor;
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
    final activePage = widget.pages[_index.clamp(0, widget.pages.length - 1)];
    final pagePalette = widget.pageColors ??
        <Color>[
          scheme.primary,
          scheme.secondary,
          scheme.tertiary,
          scheme.primaryContainer,
          scheme.secondaryContainer,
        ];
    final paletteColor = pagePalette.isEmpty
        ? scheme.primary
        : pagePalette[_index % pagePalette.length];
    final activeBackground = activePage.backgroundGradient ??
        LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (activePage.backgroundColor ?? paletteColor).withValues(alpha: 0.4),
            scheme.surface,
            scheme.surfaceContainerHighest.withValues(alpha: 0.85),
          ],
        );
    final activeForegroundColor = activePage.foregroundColor ?? scheme.onSurface;
    final buttonShape = const LiquidRoundedSuperellipse(borderRadius: 32);
    final buttonSettings = LiquidGlassSettings(
      visibility: 1,
      glassColor: scheme.surface.withValues(alpha: 0.52),
      blur: 6,
      thickness: 34,
      lightIntensity: 1.05,
      ambientStrength: 0.18,
      refractiveIndex: 1.2,
      saturation: 1.22,
    );

    final defaultBackground = AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(gradient: activeBackground),
    );

    return LiquidGlassScope.stack(
      background: widget.background ?? defaultBackground,
      content: Scaffold(
        backgroundColor: Colors.transparent,
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
                  final pageForegroundColor = page.foregroundColor ?? activeForegroundColor;
                  return SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(page.icon, size: 64, color: pageForegroundColor),
                          const SizedBox(height: 20),
                          Text(
                            page.title,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: pageForegroundColor,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            page.description,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: pageForegroundColor.withValues(alpha: 0.9),
                                ),
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
                          glowColor: scheme.primary.withValues(alpha: 0.45),
                          glowRadius: 1.25,
                          child: Text(
                            widget.skipLabel,
                            style: TextStyle(
                              color: widget.buttonTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GlassButton.custom(
                            onTap: _onNextTap,
                            shape: buttonShape,
                            settings: buttonSettings,
                            style: GlassButtonStyle.filled,
                          glowColor: scheme.primary.withValues(alpha: 0.45),
                          glowRadius: 1.25,
                          child: Text(
                            _isLastPage ? widget.doneLabel : widget.nextLabel,
                            style: TextStyle(
                              color: widget.buttonTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
      ),
    );
  }
}
