import 'package:flutter/material.dart';

@immutable
class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.description,
    this.icon = Icons.auto_awesome_rounded,
    this.child,
    this.backgroundColor,
    this.backgroundGradient,
    this.foregroundColor,
  });

  final String title;
  final String description;
  final IconData icon;
  final Widget? child;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Color? foregroundColor;
}
